import 'package:tracking/app/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/font_utils.dart';

class BaseAppbar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const BaseAppbar({super.key, this.title, this.onBackPressed, this.actions});

  @override
  BaseAppbarState createState() => BaseAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class BaseAppbarState extends State<BaseAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorManager.offWhite,

      centerTitle: false,
      titleSpacing: 16.w,
      title: Text(
        widget.title ?? "",
        style: FontUtils.bebasTextStyle.copyWith(color: ColorManager.blackSwatch[11], fontSize: 22),
      ),
      leading: widget.onBackPressed != null
          ? GestureDetector(
              onTap: widget.onBackPressed,
              child: Icon(
                Icons.arrow_back,
                color: ColorManager.blackSwatch[11],
              ),
            )
          : null,
      actions: widget.actions,
    );
  }
}
