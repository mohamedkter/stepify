import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/routes/router.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/feature/cart/data/datasources/cart_remote_data_source.dart';
import 'package:stepify/feature/cart/data/repositories/cart_repository_impl.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_cubit.dart';
import 'package:stepify/feature/checkout/data/datasource/order_remote_datasource.dart';
import 'package:stepify/feature/checkout/data/repositories/order_repository_impl.dart';
import 'package:stepify/feature/checkout/ui/cubit/order_cubit.dart';
import 'package:stepify/feature/favorite/data/repositories/favorites_repository_impl.dart';
import 'package:stepify/feature/favorite/ui/cubit/favorites_cubit.dart';

class Stepify extends StatelessWidget {
  const Stepify({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CartCubit>(
            create: (_) {
              final uid = FirebaseAuth.instance.currentUser!.uid;
              final remote =
                  CartRemoteDataSourceImpl(FirebaseFirestore.instance);
              final repo = CartRepositoryImpl(remote);
              return CartCubit(repository: repo, uid: uid);
            },
          ),
          BlocProvider<FavoritesCubit>(
            create: (_) {
              final uid = FirebaseAuth.instance.currentUser!.uid;
              final repo = FavoritesRepositoryImpl(FirebaseFirestore.instance);
              return FavoritesCubit(repository: repo, uid: uid);
            },
          ),
          BlocProvider<OrderCubit>(
            create: (_) => OrderCubit(
              OrderRepositoryImpl(
                  OrderRemoteDataSourceImpl(FirebaseFirestore.instance)),
            ),
          ),
          // TODO: you can add additional providers here
        ],
        child: MaterialApp.router(
          title: 'Stepfiy',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: ColorsManager.primaryColor),
            useMaterial3: true,
            primaryColor: ColorsManager.primaryColor,
            scaffoldBackgroundColor: ColorsManager.backgroundColor,
            iconButtonTheme: IconButtonThemeData(
              style: IconButton.styleFrom(
                backgroundColor: ColorsManager.secondaryColor,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              fillColor: ColorsManager.secondaryColor,
            ),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 32,
                height: 34 / 32,
                fontWeight: FontWeight.bold,
                color: ColorsManager.textColor,
              ),
              headlineMedium: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 26,
                height: 20 / 26,
                fontWeight: FontWeight.w600,
                color: ColorsManager.textColor,
              ),
              bodyLarge: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.5,
                color: ColorsManager.textColor,
              ),
              bodySmall: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: ColorsManager.textColor,
              ),
            ),
          ),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
