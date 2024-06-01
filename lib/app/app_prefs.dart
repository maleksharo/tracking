import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking/features/auth/domain/usecase/set_user_info_usecase.dart';

import 'di/injection.dart';
import 'resources/language_manager.dart';

const String prefsLang = "lang";
const String prefsOnBoardingViewed = "on_boarding_viewed";
const String prefsIsUserLoggedIn = "is_user_logged_in";
const String prefsToken = "prefs_token";
const String prefsEmail = "prefs_email";
const String prefsPassword = "prefs_password";
const String prefsBaseUrl = "prefs_base_url";

@Injectable()
class AppPreferences {
  final _sharedPreferences = getIt<SharedPreferences>();

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(prefsLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }

  Future<void> setString({required String prefsKey, required String value}) async {
    await _sharedPreferences.setString(prefsKey, value);
  }

  String getString({required String prefsKey}) {
    if (prefsKey == prefsToken) {
      return _sharedPreferences.getString(prefsKey) ?? "";
    } else {
      return _sharedPreferences.getString(prefsKey) ?? "";
    }
  }

  Future<void> changeAppLanguage() async {
    String? currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      await _sharedPreferences.setString(prefsLang, LanguageType.english.getValue());
    } else {
      await _sharedPreferences.setString(prefsLang, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getLocale() async {
    String? currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  Future<void> setUserLoggedIn({required SetUserInfoUseCaseParams input}) async {
    await _sharedPreferences.setBool(prefsIsUserLoggedIn, true);
    await _sharedPreferences.setString(prefsToken, input.token);
    await _sharedPreferences.setString(prefsEmail, input.email);
    await _sharedPreferences.setString(prefsPassword, input.password);
  }

  bool? isUserLoggedIn() {
    return _sharedPreferences.getBool(prefsIsUserLoggedIn) ?? false;
  }

  Future<void> logout() async {
    await _sharedPreferences.remove(prefsIsUserLoggedIn);
    await _sharedPreferences.remove(prefsToken);
    // await _sharedPreferences.remove(prefsBaseUrl);
    await configureInjection(Environment.prod);
  }
}
