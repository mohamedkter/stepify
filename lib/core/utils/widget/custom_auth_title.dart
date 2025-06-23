import 'package:flutter/material.dart';

class CustomAuthTitle extends StatelessWidget {
  final String title;
  const CustomAuthTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
        ],
      ),
    );
  }
}
