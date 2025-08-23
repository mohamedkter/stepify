import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/custom_button.dart';
import 'package:stepify/feature/cart/domain/entities/cart_item.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_cubit.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_state.dart';
import 'package:stepify/feature/checkout/ui/screens/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartCubit>().markCartAsSeen();
    return Scaffold(
      backgroundColor: ColorsManager.secondaryColor,
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          double total = 0;
          if (state is CartUpdated) {
            total = state.total;
          }

          return BottomAppBar(
            color: Colors.white,
            height: 250.h,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Subtotal",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text("Delivery fee is included",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  )),
                      const Spacer(),
                      Text("Free",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  )),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const DashedDivider(),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Text("Total",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  )),
                      const Spacer(),
                      Text("\$${total.toStringAsFixed(2)}",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  )),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    text: "CheckOut",
                    color: state is CartUpdated && state.items.isNotEmpty
                        ? Theme.of(context).primaryColor
                        : Colors.grey[500], 
                    textColor: Colors.white,
                    onPressed: state is CartUpdated && state.items.isNotEmpty
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CheckoutScreen(),
                              ),
                            );
                          }
                        : null, // لو فاضي يتعطل
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text("My Cart", style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
        backgroundColor: ColorsManager.secondaryColor,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          onPressed: () => context.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorsManager.textColor,
            size: 16.sp,
          ),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartUpdated) {
            if (state.items.isEmpty) {
              return const Center(child: Text("Your cart is empty"));
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return SwipeToControlCard(item: item);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class SwipeToControlCard extends StatelessWidget {
  final CartItem item;

  const SwipeToControlCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsManager.secondaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                item.imageUrl,
                height: 71.h,
                width: 71.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        )),
                SizedBox(height: 4.h),
                Text("\$${item.price}",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        )),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => cartCubit.decreaseQuantity(item.productId),
                icon: const Icon(Icons.remove_circle_outline),
                color: ColorsManager.primaryColor,
              ),
              Text(
                '${item.quantity}',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.primaryColor),
              ),
              IconButton(
                onPressed: () => cartCubit.increaseQuantity(item.productId),
                icon: const Icon(Icons.add_circle_outline),
                color: ColorsManager.primaryColor,
              ),
            ],
          ),
          IconButton(
            onPressed: () => cartCubit.removeFromCart(item.productId),
            icon: const Icon(Icons.delete_outline),
            color: ColorsManager.errorColor,
          )
        ],
      ),
    );
  }
}

class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  const DashedDivider({
    super.key,
    this.height = 1,
    this.color = Colors.black,
    this.dashWidth = 5,
    this.dashSpace = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: height,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
