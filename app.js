const express = require('express');
const path = require('path');
require('dotenv').config();

const app = express();

// 1. Cấu hình giao diện EJS và thư mục chứa file tĩnh (CSS, JS, ảnh)
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(express.static(path.join(__dirname, 'public')));

// 2. Cho phép đọc dữ liệu từ form HTML và dữ liệu JSON
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// 3. Phân luồng đường dẫn về các phân hệ (MOD-01 -> MOD-07)
app.use('/auth', require('./routes/authRoutes'));               // MOD-01
app.use('/users', require('./routes/userRoutes'));              // MOD-02
app.use('/courses', require('./routes/courseRoutes'));          // MOD-03
app.use('/documents', require('./routes/documentRoutes'));      // MOD-04 & MOD-05
app.use('/interactions', require('./routes/interactionRoutes'));// MOD-06
app.use('/personal', require('./routes/personalRoutes'));       // MOD-07

// 4. Đường dẫn trang chủ kiểm tra hệ thống
app.get('/', (req, res) => {
  res.send('<h1>UED DocShare - Hệ thống Chia sẻ Tài liệu Học tập (MVC Ready)</h1>');
});

// 5. Khởi chạy server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server UED DocShare đang chạy tại: http://localhost:${PORT}`);
});