import '../../../model/settings/app_settings.dart';

abstract class AppSettingsRepository {
  // load/save settings
  Future<AppSettings> load();
  
  Future<void> save(AppSettings settings);
}