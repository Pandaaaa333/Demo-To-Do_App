# Buổi 13: Dependency Injection (DI) và Service Locator

---

## 1. Dependency Injection (DI)

- **Khái niệm Dependency:** Phụ thuộc vào sự hỗ trợ của một cái gì đó hoặc việc gì đó[cite: 2]. Ví dụ: Nếu chúng ta phụ thuộc vào smartphone hay robot, đó là sự phụ thuộc (dependent)[cite: 2].
- **Mối quan hệ:** Khi class A sử dụng một số chức năng của class B, class A có quan hệ phụ thuộc với class B[cite: 2].
- **Cơ chế:** Trong Java, trước khi sử dụng method của class khác, ta phải khởi tạo object của class đó[cite: 2]. Việc chuyển giao nhiệm vụ khởi tạo object cho một thành phần khác và trực tiếp sử dụng các dependency đó được gọi là **Dependency Injection**[cite: 2].
- **Kỹ thuật:** DI giúp tách một class độc lập với các biến phụ thuộc[cite: 2]. Đây là mối quan hệ mà trong đó một class hoạt động độc lập và class còn lại phụ thuộc vào nó[cite: 2].

## 2. Tại sao cần DI trong Clean Architecture (CA)?

DI là kỹ thuật cốt lõi trong Clean Architecture để quản lý quan hệ giữa các thành phần[cite: 2]:

*   **Tuân thủ Dependency Rule:** Các tầng bên trong không phụ thuộc vào tầng bên ngoài[cite: 2]. DI cho phép các thành phần chỉ phụ thuộc vào abstraction (interface)[cite: 2].
*   **Tăng cường tính tách rời (Decoupling):** Các module liên kết qua interface, giúp hệ thống linh hoạt, dễ thay đổi và mở rộng[cite: 2].
*   **Nâng cao khả năng kiểm thử (Testability):** Dễ dàng thay thế dependency bằng đối tượng giả (mock/fake) để kiểm thử độc lập[cite: 2].
*   **Quản lý vòng đời (Lifecycle Management):** Kiểm soát cách tạo và sử dụng instance hiệu quả, tối ưu tài nguyên[cite: 2].
*   **Tính minh bạch:** Các phụ thuộc được thể hiện tường minh, giúp lập trình viên dễ hiểu cấu trúc hệ thống[cite: 2].

## 3. Service Locator (get_it)

### a. Khái niệm
- Là bộ định vị dịch vụ cực nhanh cho Dart và Flutter giúp đơn giản hóa quản lý phụ thuộc[cite: 2].
- Cung cấp khả năng truy cập đối tượng với độ phức tạp **O(1)** từ bất cứ đâu mà không cần `BuildContext` hay tạo mã (codegen)[cite: 2].

### b. Tại sao dùng get_it?
*   **Cực nhanh:** Nhờ Map của Dart[cite: 2].
*   **Type-safe:** Kiểm tra lỗi ngay khi compile[cite: 2].
*   **Dễ test:** Thay implementation bằng mock dễ dàng[cite: 2].
*   **Linh hoạt:** Không phụ thuộc framework, dùng được cho Flutter, Server, CLI[cite: 2].
*   **Tối giản:** Không cần boilerplate hay annotation[cite: 2].

### c. Các tính năng chính
*   **Singleton:** Tạo một lần, dùng toàn hệ thống (phù hợp service có state)[cite: 2].
*   **Lazy Singleton:** Chỉ tạo khi được gọi lần đầu để tiết kiệm tài nguyên[cite: 2].
*   **Factory:** Mỗi lần gọi tạo một instance mới (phù hợp object ngắn hạn)[cite: 2].

## 4. DI với Riverpod

### a. Khái niệm
- Riverpod tích hợp sẵn cơ chế DI vào hệ thống Provider[cite: 2]. Mỗi Provider đóng vai trò là một dependency[cite: 2].

### b. Bản chất và Cách hoạt động
- Provider không chỉ quản lý state mà còn đảm nhận việc: Khai báo, khởi tạo và cung cấp dependency[cite: 2].
- Các dependency được quản lý tập trung, tạo thành một **Dependency Graph** (đồ thị phụ thuộc)[cite: 2].

### c. Constructor Injection trong Riverpod
- Riverpod khuyến khích truyền dependency qua constructor của object[cite: 2].
- **Ý nghĩa:** Giúp class thể hiện rõ ràng các phụ thuộc, không có dependency ẩn, dễ bảo trì[cite: 2].

### d. Hỗ trợ Testability và Clean Architecture
- Cho phép **override** Provider trong môi trường test để thay bằng mock/fake[cite: 2].
- Giữ các layer (Presentation, Domain, Data) độc lập và tuân thủ tuyệt đối Dependency Rule[cite: 2].

## 5. So sánh Service Locator (get_it) và Constructor Injection (Riverpod)

| Tiêu chí | Service Locator (get_it) | Constructor Injection (Riverpod) |
| :--- | :--- | :--- |
| **Khái niệm** | Dùng container trung tâm để cung cấp dependency[cite: 2] | Truyền dependency trực tiếp qua constructor[cite: 2] |
| **Cách sử dụng** | Class tự lấy dependency khi cần[cite: 2] | Dependency được inject từ bên ngoài[cite: 2] |
| **Độ rõ ràng** | Dependency bị ẩn trong class[cite: 2] | Dependency được khai báo rõ ràng[cite: 2] |
| **Decoupling** | Tách rời ở mức trung bình[cite: 2] | Tách rời cao, đúng chuẩn kiến trúc[cite: 2] |
| **Testability** | Khó hơn, cần cấu hình lại container[cite: 2] | Dễ dàng test bằng cách truyền mock[cite: 2] |
| **Quản lý** | Tập trung (Global)[cite: 2] | Phân tán theo từng class[cite: 2] |
| **Phù hợp CA** | Ở mức chấp nhận được[cite: 2] | Phù hợp và khuyến khích sử dụng[cite: 2] |