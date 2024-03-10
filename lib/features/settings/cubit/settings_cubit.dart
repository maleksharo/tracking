import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking/app/app_prefs.dart';

part 'settings_state.dart';

@Injectable()
class SettingsCubit extends Cubit<SettingsState> {
  final AppPreferences appPreferences;
  SettingsCubit(this.appPreferences) : super(SettingsInitial());


  Future<void> changeLanguage() async {
    await appPreferences.changeAppLanguage();
  }
}
