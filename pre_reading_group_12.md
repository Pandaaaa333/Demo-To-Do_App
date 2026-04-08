# Nội Dung Cần Chuẩn Bị (Pre-reading) - Nhóm 12

Tài liệu này cung cấp các kiến thức nền tảng và cốt lõi cần thiết về Clean Architecture và Dependency Injection (DI) để chuẩn bị cho buổi học và phần thuyết trình.

---

## A. Kiến Thức Nền Tảng

### 1. Clean Architecture
Clean Architecture chia hệ thống thành các layer (tầng) riêng biệt để đảm bảo tính độc lập về UI, Framework, Database và có khả năng Test cao.

- **Tầng Domain (Lõi)**: Chứa các Business Logic (Entities & Use Cases) và định nghĩa các trừu tượng (Interfaces) của Data Layer (Repositories). Tầng này **hoàn toàn độc lập** với mọi công nghệ bên ngoài (không phụ thuộc vào UI, DB, hay Network).
- **Tầng Data**: Chứa các Framework kết nối dữ liệu (Local DB, REST API, Firebase), triển khai cụ thể các Repository được định nghĩa ở tầng Domain và cung cấp dữ liệu qua Data Sources.
- **Tầng Presentation**: Chứa UI (Flutter Widgets) và State Management (BLoC, Riverpod). Gọi xuống tầng Domain để lấy kết quả.

**Dependency Rule (Nguyên tắc Phụ thuộc)**: Sự phụ thuộc mã nguồn chỉ được hướng vào trong. Tầng bên ngoài (như Data, Presentation) phụ thuộc vào tầng bên trong (Domain). Domain tuyệt đối không gọi ngược ra Data.

### 2. Interfaces / Abstract Classes
Interface là một bản hợp đồng (Contract) bắt buộc các lớp triển khai nó phải tuân theo các giao thức (hàm, biến) đã được quy định, nhưng không cung cấp cài đặt cụ thể.
Trong Clean Architecture, Domain sử dụng Interfaces để giao tiếp với Data. Data bắt buộc phải triển khai Interfaces này (Dependency Inversion), giúp hệ thống dễ dàng thay đổi thư viện DB mà không cần sửa logic hệ thống bên trong lõi phần mềm.

---

## B. Nội Dung Cốt Lõi

### 1. Dependency Injection (DI)
**Dependency Injection (Tiêm phụ thuộc)** là một nguyên lý thiết kế cung cấp các đối tượng phụ thuộc (dependencies) từ bên ngoài vào trong đối tượng cần dùng nó, thay vì để đối tượng đó tự tạo (như gọi toán tử `new` bên trong Constructor).

**Tại sao cần DI trong Clean Architecture?**
- **Tuân thủ Dependency Rule:** Injection cho phép truyền các class từ Data Layer (như RepositoryImpl) vào các Use Cases thuộc Domain Layer một cách chính xác mà không phá vỡ ranh giới.
- **Decoupling (Tách rời):** Classes không còn tự quyết định vòng đời của dependency, hệ thống trở nên linh hoạt.
- **Testability (Kiểm thử):** Dễ dàng thay thế `RealRepository` sang `FakeRepository` hoặc `MockRepository` khi chạy Unit Testing.

### 2. Service Locator (get_it)
`get_it` là một Service Locator pattern nổi tiếng trong Flutter, dùng để truy xuất các Dependencies được khởi tạo. 

Cách thức hoạt động:
- **Đăng ký (Register)** thường tại hàm `init()` gọi từ `main()`:
  - `Singleton / LazySingleton`: Một đối tượng duy nhất tồn tại xuyên suốt vòng đời ứng dụng.
  - `Factory`: Mỗi lần gọi sẽ trả về một instance hoàn toàn mới (thường dùng cho BLoC/State management).
- **Truy xuất**: Cung cấp dependency dễ dàng ở bất kì đâu bằng cách gọi `get_it<T>()` / `sl<T>()`.

### 3. DI với Riverpod
Riverpod là một giải pháp State Management hoàn chỉnh có tích hợp sẵn tính năng như DI. 
- Mọi dependency (Repository, DataSource, DB, API) có thể được gói gọn trong các `Provider`.
- **Khác biệt**: Service Locator (`get_it`) đóng vai trò như một "kho chứa" truy cập toàn cục. Riverpod khuyến khích dựa trên **Constructor Injection** và truy xuất bằng `ref.watch/ref.read`, tạo tính Safe-Type và auto-dispose (tự dọn dẹp bộ nhớ) mạnh mẽ hơn.
- Cả hai (Riverpod hay Get_it) đều là các công cụ tuyệt vời để đạt được **Decoupling** và **Testability**.

---

## C. Tài Liệu Tham Khảo
[1] [GetIt Documentation](https://pub.dev/packages/get_it)
[2] [Dependency Injection in Flutter (So sánh GetIt và Riverpod)](https://codewithandrea.com/articles/flutter-state-management-riverpod/) - Tài nguyên do CodeWithAndrea biên soạn về lý do ưu tiên Riverpod/DI.
[3] [Dependency Inversion Principle (SOLID)](https://en.wikipedia.org/wiki/Dependency_inversion_principle)
