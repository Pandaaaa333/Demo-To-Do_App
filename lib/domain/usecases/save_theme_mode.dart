import '../repositories/settings_repository.dart';

/// Domain Layer - Use Case
/// Đóng gói logic "lưu theme mới".
/// Nhận SettingsRepository qua Constructor Injection.
class SaveThemeMode {
  final SettingsRepository repository;

  SaveThemeMode(this.repository); // ← Constructor Injection

  /// Lưu trạng thái Dark Mode xuống bộ nhớ
  Future<void> call(bool isDark) => repository.saveThemeMode(isDark);
}
