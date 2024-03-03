import 'package:cached_network_image/cached_network_image.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CircleImageWidget extends StatelessWidget {
  final String image;
  final BoxFit boxFit;
  final double width;
  final double height;

  const CircleImageWidget(
      {required this.image, super.key, this.boxFit = BoxFit.cover, this.width = AppSize.s40, this.height = AppSize.s40});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSize.s20,
      backgroundColor: ColorManager.white,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: image,

          fit: boxFit,
          width: width,
          height: height,
          // placeholder: (context, url) => Image.asset(GlobalImages.imageNotAvailable),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: SizedBox(
              height: 800.h,
              width: 360.w,
              child: Lottie.asset(JsonManager.loader),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
