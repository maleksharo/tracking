import 'package:auto_route/auto_route.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/routes/auth_guard.dart';
import 'package:tracking/app/routes/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
    /// Here auth guard will be run before joining the page
        AutoRoute(page: HomeRoute.page ,guards: [getIt<AuthGuard>()]),
      ];
}
