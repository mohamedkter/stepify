import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/bag_widget.dart';
import 'package:stepify/feature/cart/domain/entities/cart_item.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_cubit.dart';
import 'package:stepify/feature/favorite/domain/entities/favorite_item.dart';
import 'package:stepify/feature/favorite/ui/cubit/favorites_cubit.dart';
import 'package:stepify/feature/favorite/ui/cubit/favorites_state.dart';
import 'package:stepify/feature/home/domain/entities/product_entity.dart';

class ProductScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title:
            Text("Sneaker Shop", style: Theme.of(context).textTheme.bodyLarge),
        backgroundColor: ColorsManager.secondaryColor,
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        actions: const [BagWidget()],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: ColorsManager.textColor, size: 18),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildProductHeader(product),
                const SizedBox(height: 10),
                ShoeSliderWidget(
                    images: product.colorImages.map((e) => e.imageUrl).toList(),
                    price: product.price),
                const SizedBox(height: 32),
                _buildProductDescription(product.description),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  bool isFav = false;
                  if (state is FavoritesUpdated) {
                    isFav = state.items.any((i) => i.productId == product.id);
                  }

                  return IconButton(
                    onPressed: () {
                      final item = FavoriteItem(
                        productId: product.id,
                        name: product.name,
                        imageUrl: product.colorImages.isNotEmpty
                            ? product.colorImages.first.imageUrl
                            : "",
                        price: product.price,
                      );
                      context.read<FavoritesCubit>().toggleFavorite(item);
                    },
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border_outlined,
                      color: isFav ? Colors.red : Colors.grey,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF9F9F9),
                      shape: const CircleBorder(),
                      fixedSize: Size(50.w, 50.w),
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 250.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    final p = widget.product;
                    context.read<CartCubit>().addToCart(
                          CartItem(
                            productId: p.id,
                            name: p.name,
                            price: p.price,
                            quantity: 1,
                            imageUrl: p.colorImages.isNotEmpty
                                ? p.colorImages.first.imageUrl
                                : "",
                          ),
                        );
                    // Optional: Snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag_outlined, size: 17),
                      const SizedBox(width: 10),
                      Text(
                        'Add to Cart',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildProductHeader(ProductEntity product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        SizedBox(
          width: 200.w,
          child: Text(
            product.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          product.category,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildProductDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          maxLines: _isDescriptionExpanded ? 10 : 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: () =>
              setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
          child: Text(
            _isDescriptionExpanded ? 'Read Less' : 'Read More',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class ShoeSliderWidget extends StatefulWidget {
  final List<String> images;
  final double price;

  const ShoeSliderWidget(
      {super.key, required this.images, required this.price});

  @override
  State<ShoeSliderWidget> createState() => _ShoeSliderWidgetState();
}

class _ShoeSliderWidgetState extends State<ShoeSliderWidget> {
  int selectedIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            '\$${widget.price.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Image.network(
                  widget.images[index],
                  height: 150,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
        CustomPaint(
          size: const Size(300, 40),
          painter: ArcBasePainter(),
        ),
        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.grey[200],
                    border: isSelected
                        ? Border.all(color: Colors.blue, width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    widget.images[index],
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ArcBasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, 0),
      width: size.width * 1,
      height: size.height,
    );

    final path = Path()..addOval(rect);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
