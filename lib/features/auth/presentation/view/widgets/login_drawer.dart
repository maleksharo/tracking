import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking/app/resources/assets_manager.dart';

import 'change_server_widget.dart';

class LoginDrawer extends StatelessWidget {
  const LoginDrawer({super.key, required this.servers});

  final List<String> servers;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Drawer(
        width: 300.w,
        backgroundColor: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                100.verticalSpace,
                Image.asset(ImageManager.appLogo),
                20.verticalSpace,
                ServersDropDownWidget(
                  serversList: servers,
                  isLogout: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
