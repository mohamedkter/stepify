import 'dart:async';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_cubit.dart';
import 'package:stepify/feature/cart/ui/screen/cart_screen.dart';
import 'package:stepify/feature/favorite/ui/screen/favorite_screen.dart';
import 'package:stepify/feature/home/data/datasources/category_remote_data_source.dart';
import 'package:stepify/feature/home/data/datasources/offer_remote_data_source.dart';
import 'package:stepify/feature/home/data/repositories/category_repository_impl.dart';
import 'package:stepify/feature/home/data/repositories/offer_repository_impl.dart';
import 'package:stepify/feature/home/data/repositories/product_repository_impl.dart';
import 'package:stepify/feature/home/domain/usecases/get_categories.dart';
import 'package:stepify/feature/home/domain/usecases/get_offers.dart';
import 'package:stepify/feature/home/domain/usecases/get_products.dart';
import 'package:stepify/feature/home/ui/cubit/category_cubit.dart';
import 'package:stepify/feature/home/ui/cubit/offer_cubit.dart';
import 'package:stepify/feature/home/ui/cubit/product_cubit.dart';
import 'package:stepify/feature/home/ui/screen/home_screen.dart';
import 'package:stepify/feature/notification/ui/screen/notifications_screen.dart';
import 'package:stepify/feature/profile/show_profile/screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _bottomNavIndex = 0;

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late AnimationController _hideBottomBarAnimationController;

  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;

  final _iconList = const <IconData>[
    Icons.home_filled,
    Icons.favorite,
    Icons.notifications,
    Icons.person,
  ];

  final _titleList = const <String>[
    "Home",
    "Favorite",
    "Notification",
    "Profile",
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _fabAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _borderRadiusAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _hideBottomBarAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    final fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    final borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(borderRadiusCurve);

    // Start animations
    Future.delayed(const Duration(seconds: 1), () {
      _fabAnimationController.forward();
      _borderRadiusAnimationController.forward();
    });
  }

  List<Widget> get _screens => [
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  ProductCubit(GetProducts(ProductRepositoryImpl(FirebaseFirestore.instance)))
                    ..fetchProducts(),
            ),
            BlocProvider(
              create: (_) => CategoryCubit(GetCategories(
                  CategoryRepositoryImpl(CategoryRemoteDataSourceImpl(FirebaseFirestore.instance))))
                ..fetchCategories(),
            ),
            BlocProvider(
              create: (_) => OfferCubit(GetOffers(
                  OfferRepositoryImpl(OfferRemoteDataSourceImpl(FirebaseFirestore.instance))))
                ..fetchOffers(),
            ),
          ],
          child: const HomeScreen(),
        ),
        const FavoriteScreen(),
        const NotificationScreen(),
        const ProfileScreen(),
      ];

  void _onFabPressed() {
    _resetAnimations();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: context.read<CartCubit>(),
        child: const CartScreen(),
      ),
    ));
  }

  void _resetAnimations() {
    _fabAnimationController.reset();
    _borderRadiusAnimationController.reset();
    _borderRadiusAnimationController.forward();
    _fabAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_bottomNavIndex],
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsManager.primaryColor,
        onPressed: _onFabPressed,
        child: const Icon(Icons.shopping_bag_outlined, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? ColorsManager.primaryColor : Colors.grey;
          return Icon(_iconList[index], size: 24, color: color);
        },
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.softEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}
