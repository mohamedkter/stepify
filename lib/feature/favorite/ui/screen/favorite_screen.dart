import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/core/utils/widget/bag_widget.dart';
import 'package:stepify/feature/favorite/domain/entities/favorite_item.dart';
import 'package:stepify/feature/favorite/ui/cubit/favorites_cubit.dart';
import 'package:stepify/feature/favorite/ui/cubit/favorites_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          title: Text("Favorite", style: Theme.of(context).textTheme.bodyLarge),
          backgroundColor: ColorsManager.secondaryColor,
          elevation: 0,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          actions: const [BagWidget()],
          leading: IconButton(
            onPressed: () => context.go("/main"),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorsManager.textColor,
              size: 16.sp,
            ),
          ),
        ),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesUpdated) {
              if (state.items.isEmpty) {
                return const Center(child: Text("No favorites yet"));
              }

              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                itemCount: state.items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return FavoriteShoeCard(item: item);
                },
              );
            } else if (state is FavoritesFailure) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ));
  }
}

class FavoriteShoeCard extends StatelessWidget {
  final FavoriteItem item;

  const FavoriteShoeCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final favoritesCubit = context.read<FavoritesCubit>();

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              favoritesCubit.toggleFavorite(item); 
            },
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundColor: const Color(0xFFF9F9F9),
                radius: 15.r,
                child: Icon(
                  Icons.favorite,
                  size: 17.sp,
                  color: ColorsManager.errorColor,
                ),
              ),
            ),
          ),
          Container(
            width: 150.w,
            height: 80.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            item.name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF6A6A6A),
                  fontSize: 14.sp,
                ),
          ),
          SizedBox(height: 10.h),
          Text(
            "\$${item.price}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
          ),
        ],
      ),
    );
  }
}
