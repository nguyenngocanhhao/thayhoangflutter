# 🛍️ ThayHoangFlutter 

Ứng dụng Flutter mẫu hiển thị danh sách sản phẩm từ API công khai.  
Sử dụng `Provider` để quản lý trạng thái.

---

## 🚀 Tính năng chính

- Gọi API từ: [`https://api.escuelajs.co/api/v1/products`](https://api.escuelajs.co/api/v1/products)
- Hiển thị danh sách sản phẩm có ảnh, tên, mô tả, giá
- Thêm, sửa, xoá sản phẩm (POST, PUT, DELETE)
- Xem chi tiết sản phẩm
- Phân trang – chỉ hiển thị 10 sản phẩm và có nút “Xem thêm”
- State Management bằng `Provider`
- Giao diện tương thích Android / iOS / Web

---

## 🧱 Công nghệ sử dụng

| Công nghệ     | Mô tả                         |
|--------------|-------------------------------|
| Flutter      | SDK phát triển ứng dụng đa nền |
| Provider     | State management đơn giản      |
| HTTP         | Gửi request API RESTful        |

---

## 📸 Giao diện ứng dụng

**📋 Danh sách sản phẩm**  
_Method: GET - Get list product_

<img width="373" height="784" alt="image" src="https://github.com/user-attachments/assets/f5f6eb54-98fc-4db9-b2ce-9174dbae9305" />

**🔍 Chi tiết sản phẩm**  
_Method: GET - Get detail product_

**➕ Thêm sản phẩm**  
_Method: POST - Create product_

<img width="368" height="781" alt="image" src="https://github.com/user-attachments/assets/38bad449-b580-47b8-832a-73388ed445ac" />

**✏️ Chỉnh sửa sản phẩm**  
_Method: PUT - Update product_

<img width="358" height="308" alt="image" src="https://github.com/user-attachments/assets/509e2207-db83-4466-9fdc-716846169524" />

**🗑️ Xoá sản phẩm & phân trang sản phẩm**  
_Methods: DELETE & GET (paging)_
Trang chỉ hiện thị 10 sản phẩm xem nhiều hơn thì ấn "Xem Thêm" - Xóa thì ấn biểu tượng 🗑️ 

<img width="373" height="784" alt="image" src="https://github.com/user-attachments/assets/3593e877-f1b9-48b9-b761-e2993ec67937" />

---
## 🗂️ Cấu trúc thư mục chính
<pre lang="markdown">lib/                      # Thư mục chính chứa code
├── models/               # Định nghĩa model dữ liệu
│   └── product.dart
├── providers/            # State Management với Provider
│   └── product_provider.dart
├── screens/              # Các màn hình UI
│   ├── add_product_screen.dart
│   ├── edit_product_screen.dart
│   ├── product_detail_screen.dart
│   └── product_list_screen.dart
├── services/             # Xử lý gọi API
│   └── api_service.dart
└── main.dart             # Điểm khởi chạy của app
</code></pre>
---
## 📦 Cài đặt & chạy

```bash
git clone https://github.com/nguyenngocanhhao/thayhoangflutter.git
cd thayhoangflutter
flutter clean
flutter pub get
flutter run
