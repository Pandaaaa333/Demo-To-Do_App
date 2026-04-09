import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

/// Data Layer - Repository Implementation
/// Implements contract từ Domain Layer.
/// Nhận SettingsLocalDataSource qua Constructor Injection —
/// hoàn toàn không biết SharedPreferences là gì.
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _dataSource; // ← Constructor Injection

  SettingsRepositoryImpl(this._dataSource);

  @override
  bool getThemeMode() => _dataSource.getThemeMode();

  @override
  Future<void> saveThemeMode(bool isDark) => _dataSource.saveThemeMode(isDark);
}
