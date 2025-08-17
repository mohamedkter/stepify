import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/bag_widget.dart';
import 'package:stepify/feature/home/domain/entities/product_entity.dart';
import 'package:stepify/feature/home/ui/cubit/product_cubit.dart';
import 'package:stepify/feature/home/ui/cubit/category_cubit.dart';
import 'package:stepify/feature/home/ui/cubit/offer_cubit.dart';
import 'package:stepify/feature/home/ui/widgets/category_list_widget.dart';
import 'package:stepify/feature/home/ui/widgets/new_arrival_banner.dart';
import 'package:stepify/feature/home/ui/widgets/offer_slider.dart';
import 'package:stepify/feature/home/ui/widgets/popular_shoes_section.dart';
import 'package:stepify/feature/home/ui/widgets/search_bar_widget.dart';
import 'package:stepify/feature/home/ui/widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.secondaryColor,
      appBar: _buildAppBar(context),
      drawer: const _HomeDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchBarWidget(),
              _buildCategorySection(),
              SizedBox(height: 10.h),
              _buildPopularShoesSection(),
              _buildOfferSection(),
              SizedBox(height: 10.h),
              _buildNewArrivalsSection(),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- AppBar ----------------
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Explore", style: Theme.of(context).textTheme.headlineLarge),
      centerTitle: true,
      elevation: 0,
      surfaceTintColor: Colors.white,
      backgroundColor: ColorsManager.secondaryColor,
      actions: const [BagWidget()],
    );
  }

  /// ---------------- Category Section ----------------
  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Select Category", isSeeAllVisible: false),
        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoaded) {
              final categories = [
                "All Shoes",
                ...state.categories.map((c) => c.name),
              ];

              return CategoryListWidget(
                categories: categories,
                selectedIndex: selectedCategoryIndex,
                onCategorySelected: (index) {
                  setState(() => selectedCategoryIndex = index);
                },
              );
            } else if (state is CategoryError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  /// ---------------- Popular Shoes Section ----------------
  Widget _buildPopularShoesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Popular Shoes"),
        BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              final popularShoes = _filterPopularShoes(
                state.products,
                context,
                selectedCategoryIndex,
              );
              return PopularShoesSection(popularShoes: popularShoes);
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  /// ---------------- Offers Section ----------------
  Widget _buildOfferSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Offers"),
        BlocBuilder<OfferCubit, OfferState>(
          builder: (context, state) {
            if (state is OfferLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OfferLoaded) {
              return OfferSlider(offers: state.offers);
            } else if (state is OfferError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  /// ---------------- New Arrivals Section ----------------
  Widget _buildNewArrivalsSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "New Arrivals"),
        NewArrivalBanner(),
      ],
    );
  }

  /// ---------------- Filtering Logic ----------------
  List<ProductEntity> _filterPopularShoes(
    List<ProductEntity> products,
    BuildContext context,
    int selectedIndex,
  ) {
    final categoryState = context.read<CategoryCubit>().state;
    final allCategories = [
      "All Shoes",
      if (categoryState is CategoryLoaded)
        ...categoryState.categories.map((c) => c.name),
    ];

    final selectedCategory = allCategories[selectedIndex];

    return products.where((p) {
      if (!p.isPopular) return false;
      if (selectedCategory == "All Shoes") return true;
      return p.category == selectedCategory;
    }).toList();
  }
}

/// ---------------- Drawer ----------------
class _HomeDrawer extends StatelessWidget {
  const _HomeDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(context),
            _buildDrawerItem(Icons.person, "Profile", context),
            _buildDrawerItem(Icons.shopping_cart, "My Cart", context),
            _buildDrawerItem(Icons.favorite, "Favorite", context),
            _buildDrawerItem(Icons.shopping_bag, "Orders", context),
            _buildDrawerItem(Icons.notifications, "Notifications", context),
            _buildDrawerItem(Icons.settings, "Settings", context),
            const SizedBox(height: 20),
            const Divider(color: Colors.white, thickness: 1),
            _buildDrawerItem(Icons.logout, "Sign Out", context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage("assets/images/human4.jpg"),
          ),
          const SizedBox(height: 8),
          Text(
            'Welcome Mohamed to the \nSneaker Shop!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 20.sp,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.white,
              fontSize: 16.sp,
            ),
      ),
      onTap: () => Navigator.pop(context),
    );
  }
}
