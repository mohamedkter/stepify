import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:   Lottie.asset('assets/lottie/stepify_loading.json',
        width: 100,
        height: 100,
        fit: BoxFit.fill,
      ),
    );
  }
}