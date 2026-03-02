import 'package:flutter/widgets.dart';
import '../../data/settings/app_settings_repository.dart';
import '../../model/settings/app_settings.dart';

class AppSettingsState extends ChangeNotifier {
 final AppSettingsRepository _repository; // inject repo
  AppSettings? _appSettings;
 
  AppSettingsState(this._repository) {
    init(); // load when created
  }

  Future<void> init() async {
    // Might be used to load data from repository
    _appSettings = await _repository.load();
    notifyListeners();
  }

  ThemeColor get theme => _appSettings?.themeColor ?? ThemeColor.blue;

  Future<void> changeTheme(ThemeColor themeColor) async {
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(themeColor: themeColor);

    await _repository.save(_appSettings!); // save the new theme to repo

    notifyListeners();
  }
}
