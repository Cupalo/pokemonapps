import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CircleBackground extends StatelessWidget {
  const CircleBackground({
    super.key,
    required this.height,
    required this.width,
    this.color,
  });

  final double height;
  final double width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
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
          color: color ?? Colors.white.withOpacity(0.2),
          strokeWidth: height / 6,
        ).h(height).w(width).rotate90(),
        CircularProgressIndicator(
          value: 1,
          color: color ?? Colors.white.withOpacity(0.2),
          strokeWidth: height / 8,
        ).h(height * 0.4).w(width * 0.4),
      ],
    );
  }
}
