import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryListWidget extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CategoryListWidget({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Container(
              width: 108.w,
              height: 40.h,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color:
                    isSelected ? Theme.of(context).primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: isSelected
                    ? Border.all(color: Theme.of(context).primaryColor)
                    : Border.all(color: Colors.transparent),
              ),
              child: Text(categories[index],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 14.sp,
                      )),
            ),
          );
        },
      ),
    );
  }
}