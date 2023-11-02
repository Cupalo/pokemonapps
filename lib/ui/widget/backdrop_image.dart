import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../default/theme.dart';

class BackdropImage extends StatelessWidget {
  const BackdropImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image(
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return SizedBox(
          height: 202.5,
          width: Get.width,
          child: child,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox(
          height: 202.5,
          width: Get.width,
          child: Center(
            child: BaseTheme.loading(),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 202.5,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.black26,
          ),
          child: const Center(
            child: Image(
              image: AssetImage('assets/Logo.png'),
            ),
          ),
        );
      },
      image: NetworkImage(
        imageUrl,
      ),
    );
  }
}
