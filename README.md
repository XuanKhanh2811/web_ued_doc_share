# UED DOCSHARE - HỆ THỐNG CHIA SẺ TÀI LIỆU HỌC TẬP THEO HỌC PHẦN
**UED DocShare** là nền tảng web hỗ trợ lưu trữ, chia sẻ và tra cứu tài liệu học tập (giáo trình, slide bài giảng, đề cương ôn tập, đề thi tham khảo) được tổ chức chuẩn hóa theo **Học kỳ – Học phần – Loại tài liệu** dành riêng cho sinh viên **Trường Đại học Sư phạm - Đại học Đà Nẵng (UED)**.

### Mục tiêu & Chức năng chính
- **Chuẩn hóa kho tài liệu học tập:** Khắc phục tình trạng tài liệu trôi nổi, thất lạc qua các nhóm chat bằng cách phân loại chặt chẽ theo từng mã học phần và năm học.
- **Quy trình kiểm duyệt chất lượng:** Tài liệu do sinh viên tải lên được đưa vào hàng đợi kiểm duyệt để đảm bảo tính chính xác, đúng môn học và không vi phạm bản quyền trước khi hiển thị công khai.
- **Tương tác & Cá nhân hóa học tập:** Hỗ trợ tìm kiếm đa tiêu chí, xem trước tài liệu trực tuyến, đánh giá sao, bình luận trao đổi học thuật và lưu tài liệu vào **Tủ sách cá nhân**.
- **Phân quyền 3 vai trò rõ ràng:**
  - **Sinh viên (Student):** Tìm kiếm, xem trước, tải tài liệu, đóng góp tài liệu mới, đánh giá và bình luận.
  - **Kiểm duyệt viên (Moderator):** Tiếp nhận, thẩm định, phê duyệt hoặc từ chối tài liệu chờ duyệt.
  - **Quản trị viên (Admin):** Quản lý tài khoản người dùng, phân quyền, quản lý danh mục học kỳ, học phần và thống kê hệ thống.

### Công nghệ sử dụng (Tech Stack)
- **Backend:** Node.js, Express.js
- **Frontend:** EJS Template Engine, HTML5, CSS3, JavaScript
- **Cơ sở dữ liệu:** MySQL 8.0+ (thiết kế chuẩn 3NF gồm 12 bảng thực thể)
- **Quản lý mã nguồn & Triển khai:** Git, GitHub, Cloud Server (Railway / Render)
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
