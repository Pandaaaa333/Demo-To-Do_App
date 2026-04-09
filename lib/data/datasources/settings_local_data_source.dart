import 'package:shared_preferences/shared_preferences.dart';

/// Data Layer - Abstract Data Source
/// Interface cho local storage của Settings.
abstract class SettingsLocalDataSource {
  bool getThemeMode();
  Future<void> saveThemeMode(bool isDark);
}

/// Data Layer - Concrete Implementation
/// Đây là nơi DUY NHẤT trong toàn bộ app biết về SharedPreferences.
/// SharedPreferences được truyền qua Constructor Injection — class này
/// không tự gọi SharedPreferences.getInstance() mà nhận sẵn instance.
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences _prefs; // ← Constructor Injection
  static const _themeKey = 'theme_mode';

  SettingsLocalDataSourceImpl(this._prefs);

  @override
  bool getThemeMode() => _prefs.getBool(_themeKey) ?? false;

  @override
  Future<void> saveThemeMode(bool isDark) async {
    await _prefs.setBool(_themeKey, isDark);
  }
}
