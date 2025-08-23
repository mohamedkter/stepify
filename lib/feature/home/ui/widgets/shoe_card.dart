import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stepify/core/constants/app_icons.dart';
import 'package:stepify/core/routes/routes.dart';
import 'package:stepify/feature/cart/domain/entities/cart_item.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_cubit.dart';
import 'package:stepify/feature/favorite/domain/entities/favorite_item.dart';
import 'package:stepify/feature/favorite/ui/cubit/favorites_cubit.dart';
import 'package:stepify/feature/favorite/ui/cubit/favorites_state.dart';
import 'package:stepify/feature/home/domain/entities/product_entity.dart';

import 'package:stepify/feature/product/ui/screen/product_screen.dart';

class ShoeCard extends StatefulWidget {
  final ProductEntity product;

  const ShoeCard({
    super.key,
    required this.product,
  });

  @override
  State<ShoeCard> createState() => _ShoeCardState();
}

class _ShoeCardState extends State<ShoeCard> {
  bool isFavorite = false;

  toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          Routes.productDetails,
          extra: widget.product,
        );
      },
      child: Container(
        width: 160.w,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 100.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.product.colorImages.isNotEmpty
                            ? widget.product.colorImages.first.imageUrl
                            : "https://via.placeholder.com/150",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: IconButton(
                    icon: BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, state) {
                        bool isFav = false;
                        if (state is FavoritesUpdated) {
                          isFav = state.items
                              .any((i) => i.productId == widget.product.id);
                        }
                        return Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav
                              ? Color.fromARGB(255, 141, 22, 14)
                              : Colors.grey,
                        );
                      },
                    ),
                    onPressed: () {
                      final item = FavoriteItem(
                        productId: widget.product.id,
                        name: widget.product.name,
                        imageUrl: widget.product.colorImages.isNotEmpty
                            ? widget.product.colorImages.first.imageUrl
                            : "",
                        price: widget.product.price,
                      );
                      context.read<FavoritesCubit>().toggleFavorite(item);
                    },
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: AppIcons.svg(
                      AppIcons.logo,
                      width: 28.w,
                      height: 28.h,
                      color: Colors.grey,
                    )),
              ],
            ),
            const SizedBox(height: 8),
            Text("BEST SELLER",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    )),
            Text(widget.product.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF6A6A6A),
                    )),
            Text("\$${widget.product.price.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    )),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // Add to cart logic can be implemented here
                final p = widget.product;
                context.read<CartCubit>().addToCart(
                      CartItem(
                        productId: p.id,
                        name: p.name,
                        price: p.price,
                        quantity: 1,
                        imageUrl: p.colorImages.isNotEmpty
                            ? p.colorImages.first.imageUrl
                            : "",
                      ),
                    );
                // Optional: Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to cart')),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
