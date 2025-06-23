import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool isSeeAllVisible;
  const SectionHeader(
      {super.key, required this.title, this.isSeeAllVisible = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: isSeeAllVisible
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyLarge),
          isSeeAllVisible
              ? Text("See all",
                  style: TextStyle(
                      fontSize: 14, color: Theme.of(context).primaryColor))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}