import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/feature/product/ui/screen/product_screen.dart';

class ShoeCard extends StatefulWidget {
  final String name;
  final String price;
  final String imageUrl;

  const ShoeCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<ShoeCard> createState() => _ShoeCardState();
}

class _ShoeCardState extends State<ShoeCard> {
  bool isFavorite = false;

  toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProductScreen(),
          ),
        );
      },
      child: Container(
        width: 160.w,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: toggleFavorite,
              child: Align(
                alignment: Alignment.topLeft,
                child: isFavorite
                    ? const Icon(Icons.favorite,
                        size: 22, color: ColorsManager.errorColor)
                    : const Icon(Icons.favorite_border, size: 22),
              ),
            ),
            Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text("BEST SELLER",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    )),
            Text(widget.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF6A6A6A),
                    )),
            Text(widget.price,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
