
import 'package:flutter/material.dart';
import 'package:stepify/core/themes/colors.dart';

class CustomAuthTextInputField extends StatelessWidget {
  final String  label;
  final TextEditingController? controller;
  final String hintText;
  const CustomAuthTextInputField({
    super.key, required this.label, this.controller, required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorsManager.textColor.withOpacity(0.5),
                      ),
              filled: true,
              fillColor:
                  Theme.of(context).inputDecorationTheme.fillColor,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                borderSide:
                    BorderSide(color: ColorsManager.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


