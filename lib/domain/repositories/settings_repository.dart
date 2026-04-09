/// Domain Layer - Abstract Repository
/// Quy tắc: Domain không biết gì về implementation cụ thể (SharedPreferences, Hive, v.v.)
/// Chỉ định nghĩa "hợp đồng" mà Data Layer phải thực hiện.
abstract class SettingsRepository {
  /// Trả về true nếu Dark Mode đang bật
  bool getThemeMode();

  /// Lưu trạng thái Dark Mode
  Future<void> saveThemeMode(bool isDark);
}
