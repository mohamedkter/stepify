import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stepify/core/constants/app_icons.dart';
import 'package:stepify/core/routes/routes.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_cubit.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_state.dart';

class BagWidget extends StatelessWidget {
  const BagWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.cart); // Navigate to cart screen
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            bool showBadge = false;

            if (state is CartUpdated) {
              showBadge =
                  state.hasNewItems; // هنا العلامة الحمراء بتظهر بس لو في جديد
            }

            return Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: AppIcons.svg(
                    AppIcons.cart,
                    width: 24,
                    height: 24,
                    color: Colors.black,
                  ),
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
      ),
    );
  }
}
