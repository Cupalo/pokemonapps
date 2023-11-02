import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CircleBackground extends StatelessWidget {
  const CircleBackground({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: height,
    //   width: width,
    //   decoration: BoxDecoration(
    //     shape: BoxShape.circle,
    //     color: Colors.white.withOpacity(0.2),
    //   ),
    //   child: Container(
    //     height: height * 2 / 3,
    //     width: width * 2 / 3,
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       color: Colors.grey.withOpacity(0.2),
    //     ),
    //     child: Container(
    //       height: height * 0.4,
    //       width: width * 0.4,
    //       decoration: BoxDecoration(
    //         shape: BoxShape.circle,
    //         color: Colors.white.withOpacity(0.2),
    //       ),
    //     ).centered(),
    //   ).centered(),
    // );
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
        CircularProgressIndicator(
          value: 0.95,
          color: Colors.white.withOpacity(0.2),
          strokeWidth: height / 6,
          // strokeWidth: 50,
        ).h(height).w(width).rotate90(),
        CircularProgressIndicator(
          value: 1,
          color: Colors.white.withOpacity(0.2),
          strokeWidth: height / 8,
          // strokeWidth: 50,
        ).h(height * 0.4).w(width * 0.4),
      ],
    );
  }
}
