import '../repositories/settings_repository.dart';

/// Domain Layer - Use Case
/// Đóng gói logic "đọc theme hiện tại".
/// Nhận SettingsRepository qua Constructor Injection.
class GetThemeMode {
  final SettingsRepository repository;

  GetThemeMode(this.repository); // ← Constructor Injection

  /// Trả về true nếu Dark Mode đang được bật
  bool call() => repository.getThemeMode();
}
