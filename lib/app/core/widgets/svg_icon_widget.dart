import 'package:tracking/app/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconWidget extends StatelessWidget {
  final double width;
  final double height;
  final BoxFit fit;
  final String svgIcon;
  final Function? onPressed;
  final Color? color;

  const SvgIconWidget({
    super.key,
    this.width = AppSize.s24,
    this.height = AppSize.s24,
    this.fit = BoxFit.cover,
    required this.svgIcon,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: SvgPicture.asset(
        svgIcon,
        width: width,
        height: height,
        fit: fit,
        color: color,
      ),
    );
  }
}
