-- =========================================================================
-- CƠ SỞ DỮ LIỆU HỆ THỐNG CHIA SẺ TÀI LIỆU HỌC TẬP UED DOCSHARE
-- Hệ quản trị: MySQL 8.0+ | Storage Engine: InnoDB | Charset: utf8mb4
-- =========================================================================

DROP DATABASE IF EXISTS ued_docshare;
CREATE DATABASE ued_docshare
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE ued_docshare;

-- 1. Bảng Vai trò (ENT-01)
CREATE TABLE TB_VAI_TRO (
    id_vai_tro INT NOT NULL AUTO_INCREMENT,
    ten_vai_tro VARCHAR(50) NOT NULL,
    mo_ta VARCHAR(255) NULL DEFAULT NULL,
    PRIMARY KEY (id_vai_tro),
    UNIQUE KEY uq_ten_vai_tro (ten_vai_tro)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Bảng Tài khoản (ENT-02)
CREATE TABLE TB_TAI_KHOAN (
    id_tai_khoan INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    trang_thai TINYINT(1) NOT NULL DEFAULT 1,
    ngay_tao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    lan_dang_nhap_cuoi DATETIME NULL DEFAULT NULL,
    id_vai_tro INT NOT NULL DEFAULT 3,
    PRIMARY KEY (id_tai_khoan),
    UNIQUE KEY uq_username (username),
    UNIQUE KEY uq_email (email),
    CONSTRAINT chk_tk_trang_thai CHECK (trang_thai IN (0, 1)),
    CONSTRAINT fk_taikhoan_vaitro FOREIGN KEY (id_vai_tro)
        REFERENCES TB_VAI_TRO(id_vai_tro)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Bảng Hồ sơ sinh viên (ENT-03) - Quan hệ 1-1 với TB_TAI_KHOAN
CREATE TABLE TB_HO_SO_SINH_VIEN (
    id_ho_so INT NOT NULL AUTO_INCREMENT,
    id_tai_khoan INT NOT NULL,
    ho_ten VARCHAR(100) NOT NULL,
    ngay_sinh DATE NULL DEFAULT NULL,
    gioi_tinh VARCHAR(10) NULL DEFAULT NULL,
    lop_hoc VARCHAR(50) NULL DEFAULT NULL,
    khoa VARCHAR(100) NULL DEFAULT 'Toán - Tin',
    nganh VARCHAR(100) NULL DEFAULT 'Công nghệ Thông tin',
    sdt VARCHAR(15) NULL DEFAULT NULL,
    dia_chi VARCHAR(255) NULL DEFAULT NULL,
    anh_dai_dien VARCHAR(255) NULL DEFAULT 'default-avatar.png',
    PRIMARY KEY (id_ho_so),
    UNIQUE KEY uq_hoso_taikhoan (id_tai_khoan),
    CONSTRAINT fk_hoso_taikhoan FOREIGN KEY (id_tai_khoan)
        REFERENCES TB_TAI_KHOAN(id_tai_khoan)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Bảng Nhật ký đăng nhập (ENT-04)
CREATE TABLE TB_LOG_DANG_NHAP (
    id_log INT NOT NULL AUTO_INCREMENT,
    id_tai_khoan INT NOT NULL,
    loai_hanh_dong VARCHAR(50) NOT NULL,
    thoi_gian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ip_dang_nhap VARCHAR(45) NULL DEFAULT NULL,
    thiet_bi VARCHAR(255) NULL DEFAULT NULL,
    PRIMARY KEY (id_log),
    CONSTRAINT fk_log_taikhoan FOREIGN KEY (id_tai_khoan)
        REFERENCES TB_TAI_KHOAN(id_tai_khoan)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Bảng Học kỳ (ENT-05)
CREATE TABLE TB_HOC_KY (
    id_hoc_ky INT NOT NULL AUTO_INCREMENT,
    ten_hoc_ky VARCHAR(50) NOT NULL,
    nam_hoc VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_hoc_ky),
    UNIQUE KEY uq_hocky_namhoc (ten_hoc_ky, nam_hoc)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Bảng Học phần (ENT-06)
CREATE TABLE TB_HOC_PHAN (
    id_hoc_phan INT NOT NULL AUTO_INCREMENT,
    ma_hoc_phan VARCHAR(20) NOT NULL,
    ten_hoc_phan VARCHAR(150) NOT NULL,
    so_tin_chi TINYINT NOT NULL DEFAULT 3,
    id_hoc_ky INT NOT NULL,
    PRIMARY KEY (id_hoc_phan),
    UNIQUE KEY uq_ma_hoc_phan (ma_hoc_phan),
    CONSTRAINT chk_so_tin_chi CHECK (so_tin_chi BETWEEN 1 AND 10),
    CONSTRAINT fk_hocphan_hocky FOREIGN KEY (id_hoc_ky)
        REFERENCES TB_HOC_KY(id_hoc_ky)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Bảng Loại tài liệu (ENT-07)
CREATE TABLE TB_LOAI_TAI_LIEU (
    id_loai_tai_lieu INT NOT NULL AUTO_INCREMENT,
    ten_loai VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_loai_tai_lieu),
    UNIQUE KEY uq_ten_loai (ten_loai)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Bảng Tài liệu (ENT-08)
CREATE TABLE TB_TAI_LIEU (
    id_tai_lieu INT NOT NULL AUTO_INCREMENT,
    ten_tai_lieu VARCHAR(200) NOT NULL,
    id_hoc_phan INT NOT NULL,
    id_loai_tai_lieu INT NOT NULL,
    id_nguoi_dang INT NOT NULL,
    duong_dan VARCHAR(255) NOT NULL,
    dung_luong_kb INT NOT NULL DEFAULT 0,
    trang_thai_duyet TINYINT(1) NOT NULL DEFAULT 0,
    luot_xem INT NOT NULL DEFAULT 0,
    luot_tai INT NOT NULL DEFAULT 0,
    ngay_dang DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_tai_lieu),
    CONSTRAINT chk_dung_luong CHECK (dung_luong_kb >= 0),
    CONSTRAINT chk_trang_thai_duyet CHECK (trang_thai_duyet IN (0, 1, 2)),
    CONSTRAINT chk_luot_xem CHECK (luot_xem >= 0),
    CONSTRAINT chk_luot_tai CHECK (luot_tai >= 0),
    CONSTRAINT fk_tailieu_hocphan FOREIGN KEY (id_hoc_phan)
        REFERENCES TB_HOC_PHAN(id_hoc_phan)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_tailieu_loai FOREIGN KEY (id_loai_tai_lieu)
        REFERENCES TB_LOAI_TAI_LIEU(id_loai_tai_lieu)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_tailieu_nguoidang FOREIGN KEY (id_nguoi_dang)
        REFERENCES TB_TAI_KHOAN(id_tai_khoan)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. Bảng Bình luận (ENT-09)
CREATE TABLE TB_BINH_LUAN (
    id_binh_luan INT NOT NULL AUTO_INCREMENT,
    id_tai_lieu INT NOT NULL,
    id_tai_khoan INT NOT NULL,
    noi_dung TEXT NOT NULL,
    thoi_gian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_binh_luan),
    CONSTRAINT fk_binhluan_tailieu FOREIGN KEY (id_tai_lieu)
        REFERENCES TB_TAI_LIEU(id_tai_lieu)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_binhluan_taikhoan FOREIGN KEY (id_tai_khoan)
        REFERENCES TB_TAI_KHOAN(id_tai_khoan)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 10. Bảng Đánh giá tài liệu (ENT-10)
CREATE TABLE TB_DANH_GIA_TAI_LIEU (
    id_danh_gia INT NOT NULL AUTO_INCREMENT,
    id_tai_khoan INT NOT NULL,
    id_tai_lieu INT NOT NULL,
    so_sao TINYINT(1) NOT NULL,
    nhan_xet VARCHAR(500) NULL DEFAULT NULL,
    thoi_gian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_danh_gia),
    UNIQUE KEY uq_danhgia_user_doc (id_tai_khoan, id_tai_lieu),
    CONSTRAINT chk_so_sao CHECK (so_sao BETWEEN 1 AND 5),
    CONSTRAINT fk_danhgia_taikhoan FOREIGN KEY (id_tai_khoan)
        REFERENCES TB_TAI_KHOAN(id_tai_khoan)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_danhgia_tailieu FOREIGN KEY (id_tai_lieu)
        REFERENCES TB_TAI_LIEU(id_tai_lieu)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 11. Bảng Tủ sách cá nhân (ENT-11)
CREATE TABLE TB_TU_SACH_CA_NHAN (
    id_luu INT NOT NULL AUTO_INCREMENT,
    id_tai_khoan INT NOT NULL,
    id_tai_lieu INT NOT NULL,
    ngay_luu DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_luu),
    UNIQUE KEY uq_tusach_user_doc (id_tai_khoan, id_tai_lieu),
    CONSTRAINT fk_tusach_taikhoan FOREIGN KEY (id_tai_khoan)
        REFERENCES TB_TAI_KHOAN(id_tai_khoan)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_tusach_tailieu FOREIGN KEY (id_tai_lieu)
        REFERENCES TB_TAI_LIEU(id_tai_lieu)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 12. Bảng Thông báo (ENT-12)
CREATE TABLE TB_THONG_BAO (
    id_thong_bao INT NOT NULL AUTO_INCREMENT,
    id_tai_khoan INT NOT NULL,
    tieu_de VARCHAR(200) NOT NULL,
    noi_dung TEXT NOT NULL,
    trang_thai_doc TINYINT(1) NOT NULL DEFAULT 0,
    thoi_gian DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_thong_bao),
    CONSTRAINT chk_trang_thai_doc CHECK (trang_thai_doc IN (0, 1)),
    CONSTRAINT fk_thongbao_taikhoan FOREIGN KEY (id_tai_khoan)
        REFERENCES TB_TAI_KHOAN(id_tai_khoan)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =========================================================================
-- DỮ LIỆU DANH MỤC KHỞI TẠO BAN ĐẦU (SEED DATA)
-- =========================================================================
INSERT INTO TB_VAI_TRO (id_vai_tro, ten_vai_tro, mo_ta) VALUES
(1, 'Admin', 'Quản trị viên toàn quyền vận hành hệ thống và phân quyền'),
(2, 'Moderator', 'Kiểm duyệt viên rà soát chất lượng học liệu và bình luận'),
(3, 'Student', 'Sinh viên UED tra cứu, tải xuống và đóng góp học liệu');

INSERT INTO TB_LOAI_TAI_LIEU (ten_loai) VALUES
('Slide bài giảng'),
('Đề thi & Đáp án'),
('Bài tập lớn / Đồ án mẫu'),
('Giáo trình & Sách tham khảo');

INSERT INTO TB_HOC_KY (ten_hoc_ky, nam_hoc) VALUES
('Học kỳ 1', '2026-2027'),
('Học kỳ 2', '2026-2027');