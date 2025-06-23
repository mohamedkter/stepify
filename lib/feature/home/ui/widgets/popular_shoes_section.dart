
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/feature/home/ui/widgets/shoe_card.dart';

class PopularShoesSection extends StatelessWidget {
  final List<Map<String, String>> popularShoes;

  const PopularShoesSection({super.key, required this.popularShoes});

  @override
  Widget build(BuildContext context) {
    return 
        SizedBox(
          height: 230.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: popularShoes.length,
            itemBuilder: (context, index) {
              final shoe = popularShoes[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == popularShoes.length - 1 ? 0 : 10,
                ),
                child: ShoeCard(
                  name: shoe["name"]!,
                  price: shoe["price"]!,
                  imageUrl: shoe["imageUrl"]!,
                ),
              );
            },
          ),
      
    );
  }
}
