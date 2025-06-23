import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stepify/core/cache/cache_helper.dart';
import 'package:stepify/core/firebase/firebase_service.dart';
import 'package:stepify/stepify.dart';
import 'package:device_preview/device_preview.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await FirebaseService.initialize();

  // Initialize the cache helper
  await CacheHelper.init();
  
  runApp(
    DevicePreview(
      enabled: !kReleaseMode && !kIsWeb,
      builder: (context) => const Stepify(),
    ),
  );
}
