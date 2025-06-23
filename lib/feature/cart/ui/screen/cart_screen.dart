import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.secondaryColor,
      bottomNavigationBar: BottomAppBar(
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
                      "\$300",
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            )),
                    const Spacer(),
                    Text("Free",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            )),
                    const Spacer(),
                    Text("\$300",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            )),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomButton(
                    text: "checkOut",
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {}),
                     SizedBox(height: 20.h),
              ],
              
            )),
      ),
      appBar: AppBar(
        title: Text("My Cart", style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
         backgroundColor:ColorsManager.secondaryColor,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.secondaryColor,
                  shape: const CircleBorder(),
                  fixedSize: Size(30.w, 30.w),
                ),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: ColorsManager.textColor,
                  size: 16.sp,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const SwipeToControlCard(
                    name: "Nike Air Max",
                    price: "\$150",
                    imageUrl: "assets/products_images/product3.png",
                  );
                },
              ),
              SizedBox(height: 20.h),
              // Total price and checkout button
            ],
          ),
        ),
      ),
    );
  }
}

class SwipeToControlCard extends StatefulWidget {
  final String name;
  final String price;
  final String imageUrl;

  const SwipeToControlCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<SwipeToControlCard> createState() => _SwipeToControlCardState();
}

class _SwipeToControlCardState extends State<SwipeToControlCard> {
  double _translateX = 0;
  bool showDelete = false;
  bool showCounter = false;
  double containerWidth = double.infinity;
  int quantity = 1;

  final double maxSlide = 80.w; // تحديد المسافة القصوى للتحريك

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _translateX += details.primaryDelta!;

      if (_translateX < -maxSlide) _translateX = -maxSlide;
      if (_translateX > maxSlide) _translateX = maxSlide;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      if (_translateX >= maxSlide / 2) {
        showCounter = true;
        showDelete = false;
        _translateX = maxSlide;
      } else if (_translateX <= -maxSlide / 2) {
        showDelete = true;
        showCounter = false;
        _translateX = -maxSlide;
      } else {
        // Reset
        showDelete = false;
        showCounter = false;
        _translateX = 0;
      }
    });
  }

  void _removeItem() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${widget.name} تم حذفه")),
    );
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الخلفية
        Positioned.fill(
          child: Row(
            children: [
              // Counter background (left)
              if (showCounter)
                Container(
                  width: 70.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primaryColor,
                          shape: const CircleBorder(),
                          fixedSize: Size(30.w, 30.w),
                        ),
                        onPressed: _increaseQuantity,
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      IconButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primaryColor,
                          shape: const CircleBorder(),
                          fixedSize: Size(30.w, 30.w),
                        ),
                        onPressed: _decreaseQuantity,
                        icon: const Icon(Icons.remove, color: Colors.white),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(width: 100), // الحفاظ على المسافة عند السحب

              const Spacer(),

              // Delete background (right)
              if (showDelete)
                Container(
                  width: 70.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.errorColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.errorColor,
                      shape: const CircleBorder(),
                      fixedSize: Size(30.w, 30.w),
                    ),
                    onPressed: _removeItem,
                    icon: Icon(Icons.delete_outlined,
                        color: Colors.white, size: 28.sp),
                  ),
                )
              else
                const SizedBox(width: 100),
            ],
          ),
        ),

        // Foreground card with animation
        GestureDetector(
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: TweenAnimationBuilder(
            tween: Tween<double>(
              begin: 1.0,
              end: 1.0 - (_translateX.abs() / maxSlide) * 0.05,
            ),
            duration: const Duration(milliseconds: 100),
            builder: (context, double scale, child) {
              return Transform.translate(
                offset: Offset(_translateX, 0),
                child: Transform.scale(
                  scaleX: scale,
                  scaleY: 1.0,
                  child: child,
                ),
              );
            },
            child: Container(
              width: containerWidth,
              margin: EdgeInsets.symmetric(vertical: 10.h),
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
                      child: Image.asset(widget.imageUrl,
                          height: 71.h, width: 71.w, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              widget.price,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          'x$quantity',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
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
