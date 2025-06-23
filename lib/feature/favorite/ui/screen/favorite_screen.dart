import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/bag_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const shoesImages = [
      "assets/products_images/product1.png",
      "assets/products_images/product2.png",
      "assets/products_images/product3.png",
      "assets/products_images/product4.png",
      "assets/products_images/product1.png",
      "assets/products_images/product2.png",
      "assets/products_images/product3.png",
      "assets/products_images/product4.png",
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text("Favorite", style: Theme.of(context).textTheme.bodyLarge),
         backgroundColor:ColorsManager.secondaryColor,
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        actions: const [BagWidget()],
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
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
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ColorsManager.textColor,
                  size: 16.sp,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: shoesImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return FavoriteShoeCard(
                    name: "Nike Air Max",
                    price: "\$150.2",
                    imageUrl: shoesImages[index],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteShoeCard extends StatefulWidget {
  final String name;
  final String price;
  final String imageUrl;

  const FavoriteShoeCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<FavoriteShoeCard> createState() => _FavoriteShoeCardState();
}

class _FavoriteShoeCardState extends State<FavoriteShoeCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: toggleFavorite,
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: const Color(0xFFF9F9F9),
                  radius: 15.r,
                  child: Icon(
                    Icons.favorite,
                    size: 17.sp,
                    color: ColorsManager.errorColor,
                  ),
                ),
              ),
            ),
            Container(
              width: 150.w,
              height: 80.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "BEST SELLER",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
            ),
            Text(
              widget.name,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF6A6A6A),
                    fontSize: 14.sp,
                  ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.price,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                ),
                Row(
                  children: [
                    Container(
                      width: 15.w,
                      height: 15.h,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      width: 10.w,
                      height: 10.h,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      width: 13.w,
                      height: 13.h,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
