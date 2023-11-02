import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/default/helper.dart';
import 'package:pokemonapps/navigation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => Get.off(() => Navigation()),
    );
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Text(
            Helper.titleApps,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 60,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  color: Colors.red.shade200,
                  blurRadius: 1,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
