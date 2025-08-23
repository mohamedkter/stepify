import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stepify/core/cache/cache_helper.dart';
import 'package:stepify/core/cache/chache_keys.dart';
import 'package:stepify/core/routes/routes.dart';
import 'package:stepify/feature/auth/email_verification/ui/screen/email_verification_screen.dart';
import 'package:stepify/feature/auth/forgot_password/ui/screen/forgot_password_screen.dart';
import 'package:stepify/feature/auth/signin/ui/screen/signin_screen.dart';
import 'package:stepify/feature/auth/signin/ui/signin_cubit/signin_cubit.dart';
import 'package:stepify/feature/auth/signup/ui/screen/signup_screen.dart';
import 'package:stepify/feature/auth/signup/ui/signup_cubit/signup_cubit.dart';
import 'package:stepify/feature/cart/ui/screen/cart_screen.dart';
import 'package:stepify/feature/checkout/ui/screens/checkout_screen.dart';
import 'package:stepify/feature/home/domain/entities/offer_entity.dart';
import 'package:stepify/feature/home/domain/entities/product_entity.dart';
import 'package:stepify/feature/main/screens/main_screen.dart';
import 'package:stepify/feature/offers/ui/screen/offer_details_screen.dart';
import 'package:stepify/feature/onboarding/screens/onboarding_screen.dart';
import 'package:stepify/feature/product/ui/screen/product_screen.dart';
import 'package:stepify/feature/search/ui/screen/search_screen.dart';

abstract class AppRouter {
  // This method returns the initial route based on whether the user has visited the onboarding screen or not.
  static String getInitialRoute() {
    if (CacheHelper.getData(key: CacheKeys.onBoardingVisited) == null) {
      return Routes.onboarding;
    } else {
      if (FirebaseAuth.instance.currentUser == null) {
        return Routes.signIn;
      } else {
        return Routes.main;
      }
    }
  }

  static final router = GoRouter(
      // Set the initial location to the onboarding screen
      initialLocation: AppRouter.getInitialRoute(),
      // Get the initial route
      routes: <RouteBase>[
        // Initial route is the onboarding screen
        GoRoute(
            path: Routes.onboarding,
            builder: (context, state) => const OnboardingScreen()),

        // The home screen is the main screen of the app
        GoRoute(
            path: Routes.main, builder: (context, state) => const MainScreen()),

        // The sign-in screen is where users can log in to their accounts
        GoRoute(
            path: Routes.signIn,
            builder: (context, state) => BlocProvider(
                  create: (context) => SigninCubit(),
                  child: const SigninScreen(),
                )),

        // The sign-up screen is where users can create a new account
        GoRoute(
            path: Routes.signUp,
            builder: (context, state) => BlocProvider(
                  create: (context) => SignupCubit(),
                  child: const SignupScreen(),
                )),
        // The forgot password screen is where users can reset their password
        GoRoute(
            path: Routes.forgotPassword,
            builder: (context, state) => const ForgotPasswordScreen()),

        // The email verification screen is where users can verify their email address
        GoRoute(
          path: Routes.emailVerification,
          builder: (context, state) => const EmailVerificationScreen(),
        ),
        // the search screen is where users can search for products
        GoRoute(
          path: Routes.search,
          builder: (context, state) => const SearchScreen(),
        ),
        // the checkout screen is where users can review their cart and place an order
        GoRoute(
          path: Routes.checkout,
          builder: (context, state) => const CheckoutScreen(),
        ),
        // the product details screen is where users can view details of a specific product
        GoRoute(
          path: Routes.productDetails,
          builder: (context, state) {
            final product = state.extra as ProductEntity;
            return ProductScreen(product: product);
          },
        ),
        // the cart screen is where users can view their cart items
        GoRoute(
          path: Routes.cart,
          builder: (context, state) => const CartScreen(),
        ),

        // offer details screen is where users can view details of a specific offer
        GoRoute(
          path: Routes.offerDetails,
          builder: (context, state) {
            final offer = state.extra as OfferEntity;
            return OfferDetailsScreen(offer: offer);
          },
        )
      ]);
}
