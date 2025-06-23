import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/bag_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
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
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.secondaryColor,
                  shape: const CircleBorder(),
                  fixedSize: Size(30.w, 30.w),
                ),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ColorsManager.textColor,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildProductHeader(),
                const SizedBox(height: 10),
                const ShoeSliderWidget(),
                const SizedBox(height: 32),
                _buildProductDescription(),
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
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_outlined),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9F9F9),
                  shape: const CircleBorder(),
                  fixedSize: Size(50.w, 50.w),
                ),
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
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        size: 17,
                      ),
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

  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        SizedBox(
          width: 200.w,
          child: Text(
            'Nike Air Max 270 Essential',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Men\'s Shoes',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Men Air 270 Unit delivers unmatched, all-day comfort. '
          'The bold, running-inspired design roots you to everything Nike. '
          'Featuring our largest Max Air unit yet for incredible cushioning.',
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

  Widget _buildAddToCartButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border_outlined),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            fixedSize: Size(50.w, 50.w),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 250.w,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              elevation: 0,
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart_outlined),
                const SizedBox(width: 10),
                const Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ShoeSliderWidget extends StatefulWidget {
  const ShoeSliderWidget({super.key});

  @override
  State<ShoeSliderWidget> createState() => _ShoeSliderWidgetState();
}

class _ShoeSliderWidgetState extends State<ShoeSliderWidget> {
  final List<String> shoeImages = [
    'assets/products_images/product2.png',
    'assets/products_images/product3.png',
    'assets/products_images/product4.png',
    'assets/products_images/product5.png',
    'assets/products_images/product6.png',
    'assets/products_images/product4.png',
    'assets/products_images/product5.png',
    'assets/products_images/product6.png',
  ];

  int selectedIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            '\$179.39',
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
            itemCount: shoeImages.length,
            onPageChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Image.asset(
                  shoeImages[index],
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
            itemCount: shoeImages.length,
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
                  child: Image.asset(
                    shoeImages[index],
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
      ..color = Colors.grey.shade300 // لون القاعدة
      ..style = PaintingStyle.fill;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, 0), // مركز القاعدة
      width: size.width * 1, // العرض البيضاوي
      height: size.height, // ارتفاع كبير لإعطاء عمق 3D
    );

    final path = Path()..addOval(rect);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
