
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';

class ArrowBackIconButton extends StatelessWidget {
  final Function()? onPressed;
  const ArrowBackIconButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.secondaryColor,
              shape: const CircleBorder(),
              fixedSize:  Size(44.w, 44.w),
            ),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: ColorsManager.textColor,size: 24,),
          )
        ],
      ),
    );
  }
}
