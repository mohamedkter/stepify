import 'package:flutter/material.dart';

class CustomAuthLabel extends StatelessWidget {
  final String label;
  const CustomAuthLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
