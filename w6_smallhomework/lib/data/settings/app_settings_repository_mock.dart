import 'app_settings_repository.dart';
import '../../../model/settings/app_settings.dart';

class AppSettingsRepositoryMock implements AppSettingsRepository {
  AppSettings _settings = AppSettings(themeColor: ThemeColor.blue);

  @override
  Future<AppSettings> load() async {
    return _settings;
  }

  @override
  Future<void> save(AppSettings settings) async {
    _settings = settings;
  }
}