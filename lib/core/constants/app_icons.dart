// lib/core/constants/app_icons.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Single source of truth for all SVG icons in the app.
/// Add new icons here and you’re done ✨
class AppIcons {
  AppIcons._(); // no instances

  // Base folders (adjust if you use a different structure)
  static const String _dir = 'assets/icons';

  // Icon paths (add your real filenames)
  static const String logo = '$_dir/stepify_logo.svg';
  static const String home = '$_dir/home.svg';
  static const String cart = '$_dir/bag-4.svg';
  static const String bag = '$_dir/bag-smile.svg';
  static const String heart = '$_dir/heart.svg';
  static const String clipboardHeart ='$_dir/clipboard-heart.svg';
  static const String user = '$_dir/user-rounded.svg';
  static const String arrowLeft = '$_dir/arrow-lef.svg';
  static const String arrowRight = '$_dir/arrow-right.svg';
  static const String bell = '$_dir/bell.svg';


  /// Handy builder so you don’t repeat SvgPicture.asset everywhere.
  static SvgPicture svg(
    String asset, {
    Key? key,
    double? size,
    double? width,
    double? height,
    Color? color,
    BoxFit fit = BoxFit.contain,
    String? semanticsLabel,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    // If size is provided, use it for both width & height
    final w = width ?? size;
    final h = height ?? size;

    return SvgPicture.asset(
      asset,
      key: key,
      width: w,
      height: h,
      colorFilter:
          color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
      fit: fit,
      alignment: alignment,
      semanticsLabel: semanticsLabel,
      // You can set placeholderBuilder if you like
    );
  }
}
