import 'package:auto_route/auto_route.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/assets_manager.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _imageWidth = 250.w;
  double _imageHeight = 250.h;
  final _refreshCubit = getIt<RefreshCubit>();

  @override
  void initState() {
    super.initState();
    _animateAndReplaceTheScreen();
  }

  void _animateAndReplaceTheScreen() async {
    Future.delayed(
      const Duration(milliseconds: 600),
      () async {
        _imageHeight = 200.h;
        _imageWidth = 200.w;
        _refreshCubit.refresh();
        return Future.delayed(const Duration(seconds: 1));
      },
    ).whenComplete(() {
      /// Todo navigate to map page
      context.router.replace(const LoginRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: BlocBuilder<RefreshCubit, RefreshState>(
          bloc: _refreshCubit,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  width: _imageWidth,
                  height: _imageHeight,
                  child: Hero(tag: ImageManager.splashLogo, child: Image.asset(ImageManager.splashLogo)),
                ),
                // SizedBox(height: 32.h),
                // Text(LocaleKeys.welcomeToTogether.tr(), style: Theme.of(context).textTheme.displayMedium),
              ],
            );
          },
        ),
      ),
    );
  }
}
