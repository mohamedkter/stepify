import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_cubit.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_state.dart';

class BagWidget extends StatelessWidget {
  const BagWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          bool showBadge = false;

          if (state is CartUpdated) {
            showBadge = state.hasNewItems; // هنا العلامة الحمراء بتظهر بس لو في جديد
          }

          return Stack(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.shopping_bag_outlined, size: 28),
              ),
              if (showBadge)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
