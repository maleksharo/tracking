
import 'package:tracking/app/core/utils/font_utils.dart';
import 'package:tracking/app/core/utils/string_extensions.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAvatar extends StatelessWidget {
  final ImageProvider<Object>? image;
  final String? username;
  final double? radius;
  final VoidCallback? onEditTapped;

  const UserAvatar({
    this.image,
    this.username,
    this.radius,
    this.onEditTapped,
    super.key,
  }) : assert(
          (image == null && username != null) ||
              (image != null && username == null) ||
              (image != null || username != null),
          "You must at least provide either username or imageUrl",
        );

  @override
  Widget build(BuildContext context) {
    final isInitials = image == null;
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: ColorManager.primaryGreen,
          backgroundImage: !isInitials ? image : null,
          radius: radius,
          child: isInitials
              ? Text(
                  (username ?? '').initials,
                  style: FontUtils.nexaTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : null,
        ),
        if(onEditTapped != null)
        Positioned(
          bottom: 0,
          right: 5,
          child: GestureDetector(
            onTap: onEditTapped,
            child: SvgPicture.asset(SvgManager.editAvatar),
          ),
        ),
      ],
    );
  }
}
