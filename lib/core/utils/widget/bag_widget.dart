import 'package:flutter/material.dart';

class BagWidget extends StatelessWidget {
  const BagWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.shopping_bag_outlined, size: 28)),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
