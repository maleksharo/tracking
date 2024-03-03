// import 'package:tracking/app/di.dart';
// import 'package:tracking/app/resources/strings_manager.g.dart';
// import 'package:tracking/features/auth/presentation/view/login_view.dart';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import '../../features/splash/splash_view.dart';
//
// class Routes {
//   static const String splashRoute = '/';
//   static const String loginRoute = '/login';
//
// }
//
// class RoutesGenerator {
//   static Route<dynamic> getRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case Routes.splashRoute:
//         return MaterialPageRoute(builder: (_) => const SplashView());
//       case Routes.loginRoute:
//         initLoginModule();
//         return MaterialPageRoute(
//           builder: (_) => const LoginView(),
//         );
//
//       default:
//         return unDefinedRoute();
//     }
//   }
//
//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//         builder: (_) => Scaffold(
//               appBar: AppBar(
//                 title: const Text(LocaleKeys.noRouteFound).tr(),
//               ),
//               body: const Text(LocaleKeys.noRouteFound).tr(),
//             ));
//   }
// }
