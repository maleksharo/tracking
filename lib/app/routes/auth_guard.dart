import 'package:auto_route/auto_route.dart';
import 'package:tracking/app/app_prefs.dart';
import 'package:tracking/app/routes/router.gr.dart';
import 'package:injectable/injectable.dart';
@injectable
class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.appPreferences);

  final AppPreferences appPreferences;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if (appPreferences.isUserLoggedIn() ?? false) {
      resolver.next();
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
