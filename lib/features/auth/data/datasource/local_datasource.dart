import 'package:tracking/app/app_prefs.dart';
import 'package:tracking/features/auth/domain/usecase/set_user_info_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class LoginLocalDataSource {
  Future<void> saveUserInfo({required SetUserInfoUseCaseParams input});

  Future<SetUserInfoUseCaseParams> getUserInfo();
}

@Injectable(as: LoginLocalDataSource)
class LoginLocalDataSourceImpl extends LoginLocalDataSource {
  final AppPreferences appPreferences;

  LoginLocalDataSourceImpl({required this.appPreferences});

  @override
  Future<void> saveUserInfo({required SetUserInfoUseCaseParams input}) async {
    return await appPreferences.setUserLoggedIn(input: input);
  }

  @override
  Future<SetUserInfoUseCaseParams> getUserInfo() async {
    return SetUserInfoUseCaseParams(
      email: appPreferences.getString(prefsKey: prefsEmail).toString(),
      password: appPreferences.getString(prefsKey: prefsPassword).toString(),
      token: appPreferences.getString(prefsKey: prefsToken).toString(),
    );
  }
}
