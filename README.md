# UED DOCSHARE - HỆ THỐNG CHIA SẺ TÀI LIỆU HỌC TẬP THEO HỌC PHẦN

## 1. Cấu trúc kiến trúc MVC
- `config/`: Cấu hình kết nối cơ sở dữ liệu MySQL.
- `models/`: Tầng truy xuất dữ liệu tương ứng với 12 thực thể (`ENT-01` – `ENT-12`).
- `controllers/`: Tầng xử lý logic nghiệp vụ cho 7 phân hệ (`MOD-01` – `MOD-07`).
- `routes/`: Định tuyến API và luồng điều hướng chức năng.
- `middlewares/`: Kiểm tra xác thực phiên, phân quyền và định dạng tệp tải lên.
- `views/`: Giao diện người dùng (EJS) phân chia theo từng phân hệ.
- `database/`: Script khởi tạo cơ sở dữ liệu MySQL (`ued_docshare.sql`).

## 2. Phân công thành viên & Thư mục đảm nhận

| STT | Họ và tên | Tài khoản GitHub | Phân hệ đảm nhận | Thư mục / Tệp phụ trách chính |
| :-: | :--- | :--- | :--- | :--- |
| 1 | **Bùi Xuân Khánh** *(Trưởng nhóm)* | `@<github_khanh>` | `MOD-01` & `MOD-04` | `app.js`, `config/`, `database/`, `auth*`, `document*` |
| 2 | **<Họ tên TV 2>** | `@<github_tv2>` | `MOD-02` (Hồ sơ & Phân quyền) | `middlewares/roleMiddleware.js`, `models/userModel.js`, `controllers/userController.js`, `routes/userRoutes.js`, `views/users/` |
| 3 | **<Họ tên TV 3>** | `@<github_tv3>` | `MOD-03` (Học kỳ & Học phần) | `models/courseModel.js`, `controllers/courseController.js`, `routes/courseRoutes.js`, `views/courses/` |
| 4 | **<Họ tên TV 4>** | `@<github_tv4>` | `MOD-05` & `MOD-06` (Kiểm duyệt, Bình luận, Đánh giá) | `controllers/moderationController.js`, `models/interactionModel.js`, `controllers/interactionController.js`, `routes/interactionRoutes.js` |
| 5 | **<Họ tên TV 5>** | `@<github_tv5>` | `MOD-07` (Tủ sách, Thông báo, Thống kê) & UI | `models/utilityModel.js`, `controllers/personalController.js`, `routes/personalRoutes.js`, `views/partials/`, `views/personal/`, `public/` |