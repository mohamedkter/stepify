import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Color textColor;
  final Color? color;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(335.w, 50.h),
          backgroundColor: color ?? Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        onPressed: onPressed,
        child: Text(
          text ?? "Get Started",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: textColor),
        ));
  }
}
