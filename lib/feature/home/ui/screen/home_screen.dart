import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/bag_widget.dart';
import 'package:stepify/feature/home/models/offer_model.dart';
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

  final List<String> categories = [
    "All Shoes",
    "Outdoor",
    "Tennis",
    "Running",
    "Formal",
  ];
  final List<Map<String, String>> popularShoes = [
    {
      "name": "Nike Jordan",
      "price": "\$302.00",
      "imageUrl": "assets/products_images/product6.png"
    },
    {
      "name": "Nike Air Max",
      "price": "\$752.00",
      "imageUrl": "assets/products_images/product4.png"
    },
    {
      "name": "Adidas Runner",
      "price": "\$199.00",
      "imageUrl": "assets/products_images/product6.png"
    },
    {
      "name": "Puma Ultra",
      "price": "\$169.00",
      "imageUrl": "assets/products_images/product2.png"
    },
  ];
  List<OfferModel> offers = [
  OfferModel(
    title: "50% Off Sneakers",
    description: "Get 50% off on selected sneakers for a limited time!",
    imageUrl: "assets/images/offer_images/offer1.png",
    startDate: DateTime.parse("2025-04-20T00:00:00.000Z"),
    endDate: DateTime.parse("2025-04-30T23:59:59.000Z"),
    isActive: true,
  ),
  OfferModel(
    title: "Buy 1 Get 1 Free",
    description: "Buy one pair of shoes and get another free on selected styles!",
    imageUrl: "assets/images/offer_images/offer2.png",
    startDate: DateTime.parse("2025-04-21T00:00:00.000Z"),
    endDate: DateTime.parse("2025-05-05T23:59:59.000Z"),
    isActive: true,
  ),
  OfferModel(
    title: "Ramadan Sale 30%",
    description: "Celebrate with 30% off on all items during Ramadan!",
    imageUrl: "assets/images/offer_images/offer3.png",
    startDate: DateTime.parse("2025-04-15T00:00:00.000Z"),
    endDate: DateTime.parse("2025-04-29T23:59:59.000Z"),
    isActive: true,
  ),
  OfferModel(
    title: "Weekend Flash Sale",
    description: "Limited time weekend sale. Up to 60% off!",
    imageUrl: "assets/images/offer_images/offer4.png",
    startDate: DateTime.parse("2025-04-25T00:00:00.000Z"),
    endDate: DateTime.parse("2025-04-27T23:59:59.000Z"),
    isActive: false,
  ),
  OfferModel(
    title: "New Arrival Discount",
    description: "Get 20% off on new arrivals for the first week!",
    imageUrl: "assets/images/offer_images/offer5.png",
    startDate: DateTime.parse("2025-04-19T00:00:00.000Z"),
    endDate: DateTime.parse("2025-04-26T23:59:59.000Z"),
    isActive: true,
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorsManager.secondaryColor,
      appBar: AppBar(
        title:
            Text("Explore", style: Theme.of(context).textTheme.headlineLarge),
        centerTitle: true,
         elevation: 0,
         surfaceTintColor: Colors.white,
          backgroundColor:ColorsManager.secondaryColor,
        actions: const [
          BagWidget(),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
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
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 20.sp,
                              ),
                    ),
                  ],
                ),
              ),

              // Profile
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: Text('Profile',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                onTap: () => Navigator.pop(context),
              ),

              // My Cart
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.white),
                title: Text('My Cart',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                onTap: () => Navigator.pop(context),
              ),

              // Favorite
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.white),
                title: Text('Favorite',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                onTap: () => Navigator.pop(context),
              ),

              // Orders
              ListTile(
                leading: const Icon(Icons.shopping_bag, color: Colors.white),
                title: Text('Orders',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                onTap: () => Navigator.pop(context),
              ),

              // Notifications
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.white),
                title: Text('Notifications',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                onTap: () => Navigator.pop(context),
              ),

              // Settings
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title: Text('Settings',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.white, thickness: 1),
              // Sign Out
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: Text('Sign Out',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        )),
                onTap: () {
                  // Add your sign out logic here
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchBarWidget(),
              const SectionHeader(
                  title: "Select Category", isSeeAllVisible: false),
              CategoryListWidget(
                categories: categories,
                selectedIndex: selectedCategoryIndex,
                onCategorySelected: (index) {
                  setState(() => selectedCategoryIndex = index);
                },
              ),
              SizedBox(height: 10.h),
              const SectionHeader(title: "Popular Shoes"),
              PopularShoesSection(
                popularShoes: popularShoes,
              ),
               SizedBox(height: 10.h),
              const SectionHeader(title: "Offers"),
               OfferSlider(offers:offers),
               SizedBox(height: 10.h),
              const SectionHeader(title: "New Arrivals"),
              const NewArrivalBanner(),
            ],
          ),
        ),
      ),
    );
  }
}
