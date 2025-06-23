import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewArrivalBanner extends StatelessWidget {
  const NewArrivalBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 150.h,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20.r),
        image: const DecorationImage(
          image: AssetImage("assets/products_images/offer1.png"),
          fit: BoxFit.fill, // fills the banner area
        ),
      ),
    );
  }
}
