CREATE TABLE KhuVuc (
    maKhuVuc INT PRIMARY KEY,
    tenKhuVuc NVARCHAR(255),
    moTa NVARCHAR(500)
);

CREATE TABLE LoaiPhong (
    maLoaiPhong INT PRIMARY KEY,
    tenLoaiPhong NVARCHAR(50),
    moTa NVARCHAR(500),
    giaCoBan DECIMAL(18,2),
    hinhAnh NVARCHAR(255)
);

CREATE TABLE TrangThaiPhong (
    maTrangThaiPhong INT PRIMARY KEY,
    tenTrangThai NVARCHAR(50)
);

CREATE TABLE Phong (
    maPhong INT PRIMARY KEY,
    maKhuVuc INT NOT NULL,
    soPhong NVARCHAR(50) UNIQUE,
    maLoaiPhong INT NOT NULL,
    sucChua INT,
    giaMoiDem DECIMAL(18,2),
    maTrangThaiPhong INT NOT NULL,
    dienTich DECIMAL(10,2),
    soGiuong INT,
    FOREIGN KEY (maKhuVuc) REFERENCES KhuVuc(maKhuVuc),
    FOREIGN KEY (maLoaiPhong) REFERENCES LoaiPhong(maLoaiPhong),
    FOREIGN KEY (maTrangThaiPhong) REFERENCES TrangThaiPhong(maTrangThaiPhong)
);

CREATE TABLE ThietBiPhong (
    maThietBiPhong INT PRIMARY KEY,
    maPhong INT NOT NULL,
    loaiThietBi NVARCHAR(255),
    soLuong INT,
    tinhTrang NVARCHAR(50),
    ngayCapNhat DATETIME,
    FOREIGN KEY (maPhong) REFERENCES Phong(maPhong)
);

CREATE TABLE TaiKhoan (
    maTaiKhoan INT PRIMARY KEY,
    tenDangNhap NVARCHAR(50) UNIQUE,
    matKhau NVARCHAR(255),
    vaiTro NVARCHAR(50), -- Ví dụ: 'KhachHang', 'NhanVien', 'QuanTriVien'
    trangThai NVARCHAR(50) -- Ví dụ: 'HoatDong', 'Khoa'
);

CREATE TABLE KhachHang (
    maKhachHang INT PRIMARY KEY,
    hoTen NVARCHAR(255),
    soDienThoai NVARCHAR(20) UNIQUE,
    email NVARCHAR(255) UNIQUE,
    diaChi NVARCHAR(500),
    cmnd_cccd NVARCHAR(20),
    maTaiKhoan INT,
    FOREIGN KEY (maTaiKhoan) REFERENCES TaiKhoan(maTaiKhoan)
);

CREATE TABLE DichVu (
    maDichVu INT PRIMARY KEY,
    tenDichVu NVARCHAR(255),
    giaDichVu DECIMAL(18,2),
    moTa NVARCHAR(500)
);

CREATE TABLE DatPhong (
    maDatPhong INT PRIMARY KEY,
    maKhachHang INT NOT NULL,
    maPhong INT NOT NULL,
    ngayNhanPhong DATETIME,
    ngayTraPhong DATETIME,
    maTrangThaiDatPhong INT NOT NULL,
    loaiDatPhong NVARCHAR(20),
    soNguoiLon INT,
    soTreEm INT,
    FOREIGN KEY (maKhachHang) REFERENCES KhachHang(maKhachHang),
    FOREIGN KEY (maPhong) REFERENCES Phong(maPhong)
);

CREATE TABLE DichVuDatPhong (
    maDichVuDatPhong INT PRIMARY KEY,
    maDatPhong INT NOT NULL,
    maDichVu INT NOT NULL,
    soLuong INT,
    FOREIGN KEY (maDatPhong) REFERENCES DatPhong(maDatPhong),
    FOREIGN KEY (maDichVu) REFERENCES DichVu(maDichVu)
);

CREATE TABLE KhuyenMai (
    maKhuyenMai INT PRIMARY KEY,
    tenKhuyenMai NVARCHAR(255),
    moTa NVARCHAR(500),
    ngayBatDau DATETIME,
    ngayKetThuc DATETIME,
    loaiKhuyenMai NVARCHAR(20),
    giaTriKhuyenMai DECIMAL(18,2)
);

CREATE TABLE SuDungKhuyenMai (
    maSuDung INT PRIMARY KEY,
    maDatPhong INT NOT NULL,
    maKhuyenMai INT NOT NULL,
    soTienGiam DECIMAL(18,2),
    FOREIGN KEY (maDatPhong) REFERENCES DatPhong(maDatPhong),
    FOREIGN KEY (maKhuyenMai) REFERENCES KhuyenMai(maKhuyenMai)
);

CREATE TABLE TrangThaiDatPhong (
    maTrangThaiDatPhong INT PRIMARY KEY,
    tenTrangThai NVARCHAR(50)
);

ALTER TABLE DatPhong
ADD FOREIGN KEY (maTrangThaiDatPhong) REFERENCES TrangThaiDatPhong(maTrangThaiDatPhong);

CREATE TABLE HoaDon (
    maHoaDon INT PRIMARY KEY,
    maDatPhong INT NOT NULL,
    ngayXuatHoaDon DATETIME,
    tongTien DECIMAL(18,2),
    maTrangThaiHoaDon INT NOT NULL,
    FOREIGN KEY (maDatPhong) REFERENCES DatPhong(maDatPhong)
);

CREATE TABLE TrangThaiHoaDon (
    maTrangThaiHoaDon INT PRIMARY KEY,
    tenTrangThai NVARCHAR(50)
);

ALTER TABLE HoaDon
ADD FOREIGN KEY (maTrangThaiHoaDon) REFERENCES TrangThaiHoaDon(maTrangThaiHoaDon);

CREATE TABLE NhanVien (
    maNhanVien INT PRIMARY KEY,
    hoTen NVARCHAR(255),
    viTri NVARCHAR(50),
    soDienThoai NVARCHAR(20),
    email NVARCHAR(255),
    ngayBatDauLam DATETIME,
    luongCoBan DECIMAL(18,2),
    maTaiKhoan INT,
    FOREIGN KEY (maTaiKhoan) REFERENCES TaiKhoan(maTaiKhoan)
);

CREATE TABLE SuKien (
    maSuKien INT PRIMARY KEY,
    tenSuKien NVARCHAR(255),
    maPhong INT NOT NULL,
    ngayBatDau DATETIME,
    ngayKetThuc DATETIME,
    moTa NVARCHAR(500),
    FOREIGN KEY (maPhong) REFERENCES Phong(maPhong)
);

CREATE TABLE DanhGia (
    maDanhGia INT PRIMARY KEY,
    maKhachHang INT NOT NULL,
    maPhong INT NOT NULL,
    diemDanhGia INT,
    noiDung NVARCHAR(500),
    ngayDanhGia DATETIME,
    FOREIGN KEY (maKhachHang) REFERENCES KhachHang(maKhachHang),
    FOREIGN KEY (maPhong) REFERENCES Phong(maPhong)
);

CREATE TABLE LichSuDatPhong (
    maLichSu INT PRIMARY KEY,
    maKhachHang INT NOT NULL,
    maPhong INT NOT NULL,
    ngayDat DATETIME,
    ngayNhanPhong DATETIME,
    ngayTraPhong DATETIME,
    trangThai NVARCHAR(50), -- Ví dụ: 'HoanThanh', 'Huy'
    FOREIGN KEY (maKhachHang) REFERENCES KhachHang(maKhachHang),
    FOREIGN KEY (maPhong) REFERENCES Phong(maPhong)
);
IF OBJECT_ID('ChiTietHoaDon', 'U') IS NOT NULL
    DROP TABLE ChiTietHoaDon;

-- Tạo lại bảng ChiTietHoaDon với định nghĩa chính xác
CREATE TABLE ChiTietHoaDon (
    maChiTietHoaDon INT PRIMARY KEY,
    maHoaDon INT NOT NULL,
    loaiItem NVARCHAR(50), -- Loại chi tiết: 'Phong', 'DichVu', 'KhuyenMai', 'NhanVien',...
    tenItem NVARCHAR(255), -- Tên của dịch vụ, phòng, nhân viên phụ trách, khuyến mãi...
    soLuong INT, -- Số lượng dịch vụ, số đêm thuê phòng,...
    giaTien DECIMAL(18,2), -- Giá tiền của từng mục
    thanhTien DECIMAL(18,2), -- Thành tiền = soLuong * giaTien
    tenNhanVien NVARCHAR(255), -- Tên nhân viên thực hiện giao dịch (không dùng maNhanVien để tránh phức tạp)
    thoiGianBatDau DATETIME, -- Thời gian bắt đầu sử dụng dịch vụ hoặc check-in
    thoiGianKetThuc DATETIME, -- Thời gian kết thúc dịch vụ hoặc check-out
    soPhong NVARCHAR(50), -- Số phòng liên quan đến hóa đơn, khớp với Phong.soPhong
    maKhachHang INT, -- Khách hàng liên quan
    ghiChu NVARCHAR(500), -- Ghi chú thêm nếu có
    FOREIGN KEY (maHoaDon) REFERENCES HoaDon(maHoaDon),
    FOREIGN KEY (soPhong) REFERENCES Phong(soPhong), -- Khớp kiểu dữ liệu với Phong.soPhong (NVARCHAR)
    FOREIGN KEY (maKhachHang) REFERENCES KhachHang(maKhachHang)
);
-- KhuVuc: Bang luu tru thong tin ve cac khu vuc trong khach san
-- Table KhuVuc
INSERT INTO KhuVuc (maKhuVuc, tenKhuVuc, moTa) VALUES
(1, 'Tang 1', 'Khu vuc tang 1 gan thang may'),
(2, 'Tang 2', 'Khu vuc tang 2 yen tinh'),
(3, 'Tang 3', 'Khu vuc tang 3 co ban cong'),
(4, 'San vuon', 'Khu vuc san vuon thoang mat'),
(5, 'Tang thuong', 'Khu vuc cao cap tren tang cao'),
(6, 'Gan be boi', 'Khu vuc gan be boi tien nghi');

-- Table LoaiPhong
INSERT INTO LoaiPhong (maLoaiPhong, tenLoaiPhong, moTa, giaCoBan, hinhAnh) VALUES
(1, 'Phong don', 'Phong nho cho 1 nguoi', 200000.00, 'phongdon.jpg'),
(2, 'Phong doi', 'Phong cho 2 nguoi', 350000.00, 'phongdoi.jpg'),
(3, 'Phong gia dinh', 'Phong rong cho gia dinh', 500000.00, 'phonggd.jpg'),
(4, 'Phong VIP', 'Phong cao cap', 1000000.00, 'phongvip.jpg'),
(5, 'Phong suite', 'Phong sang trong', 1500000.00, 'suite.jpg'),
(6, 'Phong view', 'Phong co view dep', 800000.00, 'view.jpg');

-- Table TrangThaiPhong
INSERT INTO TrangThaiPhong (maTrangThaiPhong, tenTrangThai) VALUES
(1, 'Trong'),
(2, 'Da dat'),
(3, 'Dang su dung'),
(4, 'Dang sua chua'),
(5, 'Da huy'),
(6, 'Cho don dep');

-- Table Phong
INSERT INTO Phong (maPhong, maKhuVuc, soPhong, maLoaiPhong, sucChua, giaMoiDem, maTrangThaiPhong, dienTich, soGiuong) VALUES
(1, 1, 'P101', 1, 1, 250000.00, 1, 15.50, 1),
(2, 2, 'P202', 2, 2, 400000.00, 2, 20.00, 1),
(3, 3, 'P303', 3, 4, 600000.00, 1, 30.00, 2),
(4, 4, 'P401', 4, 2, 1200000.00, 3, 35.00, 1),
(5, 5, 'P502', 5, 3, 1800000.00, 1, 50.00, 2),
(6, 6, 'P601', 6, 2, 900000.00, 2, 25.00, 1);

-- Table ThietBiPhong
INSERT INTO ThietBiPhong (maThietBiPhong, maPhong, loaiThietBi, soLuong, tinhTrang, ngayCapNhat) VALUES
(1, 1, 'TV', 1, 'Tot', '2025-03-01 10:00:00'),
(2, 2, 'Dieu hoa', 1, 'Tot', '2025-03-02 14:00:00'),
(3, 3, 'May nuoc nong', 1, 'Hong', '2025-03-03 09:00:00'),
(4, 4, 'Wifi router', 1, 'Tot', '2025-03-04 15:00:00'),
(5, 5, 'Minibar', 1, 'Tot', '2025-03-05 12:00:00'),
(6, 6, 'Den ngu', 2, 'Tot', '2025-03-06 08:00:00');

-- Table TaiKhoan
INSERT INTO TaiKhoan (maTaiKhoan, tenDangNhap, matKhau, vaiTro, trangThai) VALUES
(1, 'khach1', 'pass123', 'KhachHang', 'HoatDong'),
(2, 'khach2', 'pass456', 'KhachHang', 'HoatDong'),
(3, 'nv1', 'nv123', 'NhanVien', 'HoatDong'),
(4, 'nv2', 'nv456', 'NhanVien', 'HoatDong'),
(5, 'admin1', 'admin123', 'QuanTriVien', 'HoatDong'),
(6, 'khach3', 'pass789', 'KhachHang', 'Khoa');

-- Table KhachHang
INSERT INTO KhachHang (maKhachHang, hoTen, soDienThoai, email, diaChi, cmnd_cccd, maTaiKhoan) VALUES
(1, 'Nguyen Van A', '0901234567', 'nva@gmail.com', 'Ha Noi', '123456789', 1),
(2, 'Tran Thi B', '0912345678', 'ttb@gmail.com', 'TP HCM', '987654321', 2),
(3, 'Le Van C', '0923456789', 'lvc@gmail.com', 'Da Nang', '456789123', NULL),
(4, 'Pham Thi D', '0934567890', 'ptd@gmail.com', 'Hue', '321654987', 6),
(5, 'Hoang Van E', '0945678901', 'hve@gmail.com', 'Nha Trang', '147258369', NULL),
(6, 'Nguyen Thi F', '0956789012', 'ntf@gmail.com', 'Can Tho', '258369147', NULL);

-- Table DichVu
INSERT INTO DichVu (maDichVu, tenDichVu, giaDichVu, moTa) VALUES
(1, 'An sang', 50000.00, 'Bua sang tu chon'),
(2, 'Giat ui', 30000.00, 'Giat va ui quan ao'),
(3, 'Thue xe', 200000.00, 'Thue xe may di lai'),
(4, 'Massage', 300000.00, 'Massage thu gian'),
(5, 'Nuoc uong', 20000.00, 'Nuoc giai khat'),
(6, 'Tour tham quan', 500000.00, 'Tour trong ngay');

-- Table TrangThaiDatPhong
INSERT INTO TrangThaiDatPhong (maTrangThaiDatPhong, tenTrangThai) VALUES
(1, 'Da xac nhan'),
(2, 'Cho xac nhan'),
(3, 'Da huy'),
(4, 'Dang thue'),
(5, 'Da tra phong'),
(6, 'Qua han');

-- Table DatPhong
INSERT INTO DatPhong (maDatPhong, maKhachHang, maPhong, ngayNhanPhong, ngayTraPhong, maTrangThaiDatPhong, loaiDatPhong, soNguoiLon, soTreEm) VALUES
(1, 1, 1, '2025-04-01 14:00:00', '2025-04-03 12:00:00', 1, 'Online', 1, 0),
(2, 2, 2, '2025-04-02 15:00:00', '2025-04-04 11:00:00', 2, 'Tai quay', 2, 1),
(3, 3, 3, '2025-04-03 13:00:00', '2025-04-05 10:00:00', 3, 'Online', 4, 0),
(4, 4, 4, '2025-04-04 16:00:00', '2025-04-06 12:00:00', 4, 'Online', 2, 0),
(5, 5, 5, '2025-04-05 14:00:00', '2025-04-07 11:00:00', 5, 'Tai quay', 3, 1),
(6, 6, 6, '2025-04-06 15:00:00', '2025-04-08 10:00:00', 1, 'Online', 2, 0);

-- Table DichVuDatPhong
INSERT INTO DichVuDatPhong (maDichVuDatPhong, maDatPhong, maDichVu, soLuong) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 1),
(4, 4, 4, 1),
(5, 5, 5, 3),
(6, 6, 6, 1);

-- Table KhuyenMai
INSERT INTO KhuyenMai (maKhuyenMai, tenKhuyenMai, moTa, ngayBatDau, ngayKetThuc, loaiKhuyenMai, giaTriKhuyenMai) VALUES
(1, 'Giam 10%', 'Giam 10% cho dat online', '2025-03-01 00:00:00', '2025-04-30 23:59:59', 'Phan tram', 10.00),
(2, 'Giam 50k', 'Giam 50k cho phong VIP', '2025-03-15 00:00:00', '2025-04-15 23:59:59', 'Tien mat', 50000.00),
(3, 'Giam 20%', 'Giam 20% dip le', '2025-04-01 00:00:00', '2025-04-10 23:59:59', 'Phan tram', 20.00),
(4, 'Tang bua sang', 'Tang bua sang mien phi', '2025-03-20 00:00:00', '2025-04-20 23:59:59', 'Dich vu', 0.00),
(5, 'Giam 15%', 'Giam 15% cho khach cu', '2025-03-10 00:00:00', '2025-05-10 23:59:59', 'Phan tram', 15.00),
(6, 'Giam 100k', 'Giam 100k phong suite', '2025-04-01 00:00:00', '2025-04-30 23:59:59', 'Tien mat', 100000.00);

-- Table SuDungKhuyenMai
INSERT INTO SuDungKhuyenMai (maSuDung, maDatPhong, maKhuyenMai, soTienGiam) VALUES
(1, 1, 1, 25000.00),
(2, 2, 2, 50000.00),
(3, 3, 3, 120000.00),
(4, 4, 4, 0.00),
(5, 5, 5, 270000.00),
(6, 6, 6, 100000.00);

-- Table TrangThaiHoaDon
INSERT INTO TrangThaiHoaDon (maTrangThaiHoaDon, tenTrangThai) VALUES
(1, 'Da thanh toan'),
(2, 'Chua thanh toan'),
(3, 'Da huy'),
(4, 'Dang xu ly'),
(5, 'Qua han'),
(6, 'Hoan tien');

-- Table HoaDon
INSERT INTO HoaDon (maHoaDon, maDatPhong, ngayXuatHoaDon, tongTien, maTrangThaiHoaDon) VALUES
(1, 1, '2025-04-03 12:30:00', 475000.00, 1),
(2, 2, '2025-04-04 11:30:00', 750000.00, 2),
(3, 3, '2025-04-05 10:30:00', 1080000.00, 3),
(4, 4, '2025-04-06 12:30:00', 2400000.00, 4),
(5, 5, '2025-04-07 11:30:00', 3330000.00, 5),
(6, 6, '2025-04-08 10:30:00', 1700000.00, 1);

-- Table ChiTietHoaDon
INSERT INTO ChiTietHoaDon (maChiTietHoaDon, maHoaDon, loaiItem, tenItem, soLuong, giaTien, thanhTien, tenNhanVien, thoiGianBatDau, thoiGianKetThuc, soPhong, maKhachHang, ghiChu) VALUES
(1, 1, 'Phong', 'P101', 2, 250000.00, 500000.00, 'Nguyen Van X', '2025-04-01 14:00:00', '2025-04-03 12:00:00', 'P101', 1, 'Phong don 2 ngay'),
(2, 2, 'DichVu', 'Giat ui', 2, 30000.00, 60000.00, 'Tran Thi Y', '2025-04-02 15:00:00', '2025-04-03 10:00:00', 'P202', 2, 'Giat ui 2 lan'),
(3, 3, 'Phong', 'P303', 2, 600000.00, 1200000.00, NULL, '2025-04-03 13:00:00', '2025-04-05 10:00:00', 'P303', 3, 'Phong gia dinh 2 ngay'),
(4, 4, 'DichVu', 'Massage', 1, 300000.00, 300000.00, 'Le Van Z', '2025-04-05 10:00:00', '2025-04-05 11:00:00', 'P401', 4, 'Massage 1 gio'),
(5, 5, 'Phong', 'P502', 2, 1800000.00, 3600000.00, 'Pham Thi T', '2025-04-05 14:00:00', '2025-04-07 11:00:00', 'P502', 5, 'Phong suite 2 ngay'),
(6, 6, 'DichVu', 'Tour tham quan', 1, 500000.00, 500000.00, NULL, '2025-04-07 08:00:00', '2025-04-07 16:00:00', 'P601', 6, 'Tour 1 ngay');


-- Them du lieu cho kich ban khach hang dat nhieu phong
-- Gia su KhachHang 1 (Nguyen Van A) dat them Phong 2 (P202)
-- Tao them DatPhong moi
INSERT INTO DatPhong (maDatPhong, maKhachHang, maPhong, ngayNhanPhong, ngayTraPhong, maTrangThaiDatPhong, loaiDatPhong, soNguoiLon, soTreEm) VALUES
(7, 1, 2, '2025-04-10 14:00:00', '2025-04-12 12:00:00', 1, 'Online', 1, 0);

-- Them dich vu cho dat phong moi (neu can)
INSERT INTO DichVuDatPhong (maDichVuDatPhong, maDatPhong, maDichVu, soLuong) VALUES
(7, 7, 1, 2); -- Them 2 bua sang

-- Tao HoaDon moi cho DatPhong 7
INSERT INTO HoaDon (maHoaDon, maDatPhong, ngayXuatHoaDon, tongTien, maTrangThaiHoaDon) VALUES
(7, 7, '2025-04-12 12:30:00', 900000.00, 1); -- Tong tien = Gia phong P202 (400k * 2 dem) + An sang (50k * 2)

-- Them ChiTietHoaDon cho HoaDon 7
INSERT INTO ChiTietHoaDon (maChiTietHoaDon, maHoaDon, loaiItem, tenItem, soLuong, giaTien, thanhTien, tenNhanVien, thoiGianBatDau, thoiGianKetThuc, soPhong, maKhachHang, ghiChu) VALUES
(7, 7, 'Phong', 'P202', 2, 400000.00, 800000.00, 'Nguyen Van X', '2025-04-10 14:00:00', '2025-04-12 12:00:00', 'P202', 1, 'Phong doi 2 ngay'),
(8, 7, 'DichVu', 'An sang', 2, 50000.00, 100000.00, 'Nguyen Van X', '2025-04-11 07:00:00', '2025-04-12 09:00:00', 'P202', 1, 'An sang 2 ngay');





------------------------------------------------

-- Cap nhat Stored Procedure de in gop hoa don cho cung khach hang
IF OBJECT_ID('inrachitiethoadonplus', 'P') IS NOT NULL
    DROP PROCEDURE inrachitiethoadonplus;

CREATE PROCEDURE inrachitiethoadonplus
    @maHoaDonList NVARCHAR(MAX) -- Danh sách maHoaDon phân tách bằng dấu phẩy (ví dụ: '1,7')
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Bảng tạm lưu các dòng hiển thị
    CREATE TABLE #InvoiceLines (
        DisplayLine NVARCHAR(MAX) -- Tăng kích thước để chứa nhiều thông tin hơn
    );

    -- Bảng tạm lưu danh sách maHoaDon
    CREATE TABLE #HoaDonList (
        maHoaDon INT PRIMARY KEY
    );

    -- Parse danh sách maHoaDon vào bảng tạm (tương thích với SQL Server cũ hơn)
    DECLARE @xml AS XML;
    -- Thay thế dấu phẩy bằng cặp thẻ XML và ép kiểu thành XML
    SET @xml = CAST(('<I>' + REPLACE(@maHoaDonList, ',', '</I><I>') + '</I>') AS XML);

    INSERT INTO #HoaDonList (maHoaDon)
    SELECT DISTINCT T.N.value('.', 'INT') AS maHoaDon -- Trích xuất giá trị từ các nút XML
    FROM @xml.nodes('/I') AS T(N);

    -- Biến lưu trữ thông tin chung và tổng tiền
    DECLARE @tenKhachHangChung NVARCHAR(255);
    DECLARE @maKhachHangChung INT;
    DECLARE @ngayXuatHoaDonDau DATE;
    DECLARE @ngayXuatHoaDonCuoi DATE;
    DECLARE @soLuongHoaDon INT;
    DECLARE @grandTotal DECIMAL(18,2) = 0;
    DECLARE @isSingleCustomer BIT = 0; -- Cờ đánh dấu nếu tất cả hóa đơn thuộc về 1 khách hàng

    -- Kiểm tra xem tất cả hóa đơn có thuộc cùng một khách hàng không
    SELECT @soLuongHoaDon = COUNT(DISTINCT dp.maKhachHang)
    FROM HoaDon h
    JOIN DatPhong dp ON h.maDatPhong = dp.maDatPhong
    WHERE h.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList);

    IF @soLuongHoaDon = 1
    BEGIN
        SET @isSingleCustomer = 1;
        -- Lấy thông tin khách hàng chung và khoảng ngày
        SELECT TOP 1
            @maKhachHangChung = dp.maKhachHang,
            @tenKhachHangChung = kh.hoTen
        FROM HoaDon h
        JOIN DatPhong dp ON h.maDatPhong = dp.maDatPhong
        JOIN KhachHang kh ON dp.maKhachHang = kh.maKhachHang
        WHERE h.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList);

        SELECT 
            @ngayXuatHoaDonDau = MIN(CAST(h.ngayXuatHoaDon AS DATE)),
            @ngayXuatHoaDonCuoi = MAX(CAST(h.ngayXuatHoaDon AS DATE))
        FROM HoaDon h
        WHERE h.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList);
    END

    -- In thông tin gộp nếu là cùng 1 khách hàng
    IF @isSingleCustomer = 1
    BEGIN
        -- Tính tổng tiền trước
        SELECT @grandTotal = SUM(h.tongTien)
        FROM HoaDon h
        WHERE h.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList);

        -- In thông tin tiêu đề chung
        INSERT INTO #InvoiceLines VALUES (N'HÓA ĐƠN TỔNG HỢP');
        INSERT INTO #InvoiceLines VALUES (N'------------------------');
        INSERT INTO #InvoiceLines VALUES (N'Khách hàng: ' + @tenKhachHangChung + N' (Mã KH: ' + CAST(@maKhachHangChung AS NVARCHAR(10)) + N')');
        INSERT INTO #InvoiceLines VALUES (N'Ngày xuất từ: ' + CONVERT(NVARCHAR(10), @ngayXuatHoaDonDau, 103) + N' đến ' + CONVERT(NVARCHAR(10), @ngayXuatHoaDonCuoi, 103));

        -- Liệt kê các phòng liên quan (dùng FOR XML PATH)
        DECLARE @phongLienQuan NVARCHAR(MAX);
        SELECT @phongLienQuan = STUFF((
            SELECT DISTINCT ', ' + p.soPhong
            FROM HoaDon h
            JOIN DatPhong dp ON h.maDatPhong = dp.maDatPhong
            JOIN Phong p ON dp.maPhong = p.maPhong
            WHERE h.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList)
            FOR XML PATH('')
        ), 1, 2, '');
        IF @phongLienQuan IS NOT NULL INSERT INTO #InvoiceLines VALUES (N'Phòng liên quan: ' + @phongLienQuan);

        -- Liệt kê nhân viên liên quan (lấy các tên khác nhau, dùng FOR XML PATH)
        DECLARE @nhanVienLienQuan NVARCHAR(MAX);
        SELECT @nhanVienLienQuan = STUFF((
            SELECT DISTINCT ', ' + ISNULL(cth.tenNhanVien, 'N/A')
            FROM ChiTietHoaDon cth
            WHERE cth.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList) AND cth.tenNhanVien IS NOT NULL AND cth.tenNhanVien <> 'N/A' -- Avoid listing 'N/A' if it's the only distinct value
            FOR XML PATH('')
        ), 1, 2, '');
         IF @nhanVienLienQuan IS NOT NULL INSERT INTO #InvoiceLines VALUES (N'Nhân viên: ' + @nhanVienLienQuan);

        INSERT INTO #InvoiceLines VALUES (N'========================');
        INSERT INTO #InvoiceLines VALUES (N'CHI TIẾT THANH TOÁN:');
        INSERT INTO #InvoiceLines VALUES (N'------------------------');

        -- Mục Tiền phòng từ ChiTietHoaDon
        IF EXISTS (SELECT 1 FROM ChiTietHoaDon WHERE maHoaDon IN (SELECT maHoaDon FROM #HoaDonList) AND loaiItem = N'Phong')
        BEGIN
            INSERT INTO #InvoiceLines VALUES (N'--- Tiền phòng ---');
            INSERT INTO #InvoiceLines
            SELECT
                N'  - Phòng: ' + ISNULL(cth.soPhong, 'N/A') + N' (' + cth.tenItem + N') | SL: ' +
                CAST(ISNULL(cth.soLuong, 1) AS NVARCHAR(10)) + N' đêm | Đơn giá: ' +
                FORMAT(cth.giaTien, 'N0', 'vi-VN') + N' | Thành tiền: ' +
                FORMAT(cth.thanhTien, 'N0', 'vi-VN') +
                CASE WHEN ISNULL(cth.ghiChu, '') <> '' THEN N' | Ghi chú: ' + cth.ghiChu ELSE '' END
            FROM ChiTietHoaDon cth
            WHERE cth.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList) AND cth.loaiItem = N'Phong'
            ORDER BY cth.maHoaDon, cth.maChiTietHoaDon; -- Sắp xếp để có thứ tự hợp lý
        END

        -- Mục Dịch vụ từ DichVuDatPhong
        IF EXISTS (SELECT 1 FROM DichVuDatPhong dvdp JOIN DatPhong dp ON dvdp.maDatPhong = dp.maDatPhong JOIN HoaDon h ON dp.maDatPhong = h.maDatPhong JOIN DichVu dv ON dvdp.maDichVu = dv.maDichVu WHERE h.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList))
        BEGIN
            INSERT INTO #InvoiceLines VALUES (N'--- Dịch vụ đặt kèm ---');
            INSERT INTO #InvoiceLines
            SELECT
                N'  - Dịch vụ: ' + dv.tenDichVu + N' (Phòng: ' + p.soPhong + N') | SL: ' + -- Thêm số phòng để rõ ràng hơn
                CAST(dvdp.soLuong AS NVARCHAR(10)) + N' | Đơn giá: ' +
                FORMAT(dv.giaDichVu, 'N0', 'vi-VN') + N' | Thành tiền: ' +
                FORMAT((dv.giaDichVu * dvdp.soLuong), 'N0', 'vi-VN')
            FROM DichVuDatPhong dvdp
            JOIN DichVu dv ON dvdp.maDichVu = dv.maDichVu
            JOIN DatPhong dp ON dvdp.maDatPhong = dp.maDatPhong
            JOIN Phong p ON dp.maPhong = p.maPhong -- Join thêm Phong để lấy soPhong
            JOIN HoaDon h ON dp.maDatPhong = h.maDatPhong
            WHERE h.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList)
            ORDER BY h.maHoaDon, dvdp.maDichVuDatPhong; -- Sắp xếp
        END

        -- Mục Chi tiết khác từ ChiTietHoaDon (không phải 'Phong')
        IF EXISTS (SELECT 1 FROM ChiTietHoaDon WHERE maHoaDon IN (SELECT maHoaDon FROM #HoaDonList) AND loaiItem <> N'Phong')
        BEGIN
             INSERT INTO #InvoiceLines VALUES (N'--- Chi tiết khác (từ HĐ) ---');
             INSERT INTO #InvoiceLines
             SELECT
                 N'  - ' + cth.loaiItem + N': ' + cth.tenItem + N' (Phòng: ' + ISNULL(cth.soPhong, 'N/A') + N') | SL: ' + -- Thêm số phòng
                 CAST(ISNULL(cth.soLuong, 1) AS NVARCHAR(10)) + N' | Đơn giá: ' +
                 FORMAT(cth.giaTien, 'N0', 'vi-VN') + N' | Thành tiền: ' +
                 FORMAT(cth.thanhTien, 'N0', 'vi-VN') +
                 CASE WHEN ISNULL(cth.ghiChu, '') <> '' THEN N' | Ghi chú: ' + cth.ghiChu ELSE '' END
             FROM ChiTietHoaDon cth
             WHERE cth.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList) AND cth.loaiItem <> N'Phong'
             ORDER BY cth.maHoaDon, cth.maChiTietHoaDon; -- Sắp xếp
        END

        -- Mục Khuyến mãi
        IF EXISTS (SELECT 1 FROM SuDungKhuyenMai sdkm JOIN DatPhong dp ON sdkm.maDatPhong = dp.maDatPhong JOIN HoaDon h ON dp.maDatPhong = h.maDatPhong JOIN KhuyenMai km ON sdkm.maKhuyenMai = km.maKhuyenMai WHERE h.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList))
        BEGIN
            INSERT INTO #InvoiceLines VALUES (N'--- Khuyến mãi áp dụng ---');
            INSERT INTO #InvoiceLines
            SELECT DISTINCT -- Chỉ hiển thị mỗi loại khuyến mãi một lần nếu áp dụng nhiều lần với cùng giá trị
                N'  - Khuyến mãi: ' + km.tenKhuyenMai + N' (Phòng: ' + p.soPhong + N') | Giảm: ' +
                FORMAT(sdkm.soTienGiam, 'N0', 'vi-VN')
            FROM SuDungKhuyenMai sdkm
            JOIN KhuyenMai km ON sdkm.maKhuyenMai = km.maKhuyenMai
            JOIN DatPhong dp ON sdkm.maDatPhong = dp.maDatPhong
            JOIN Phong p ON dp.maPhong = p.maPhong -- Join thêm Phong
            JOIN HoaDon h ON dp.maDatPhong = h.maDatPhong
            WHERE h.maHoaDon IN (SELECT maHoaDon FROM #HoaDonList)
            ORDER BY N'  - Khuyến mãi: ' + km.tenKhuyenMai + N' (Phòng: ' + p.soPhong + N') | Giảm: ' + FORMAT(sdkm.soTienGiam, 'N0', 'vi-VN'); -- Sắp xếp
        END

        -- In tổng tiền cuối cùng
        INSERT INTO #InvoiceLines VALUES (N'------------------------');
        INSERT INTO #InvoiceLines VALUES (N'TỔNG CỘNG THANH TOÁN: ' + FORMAT(@grandTotal, 'N0', 'vi-VN'));
        INSERT INTO #InvoiceLines VALUES (N'========================');
    END
    ELSE -- Trường hợp nhiều khách hàng hoặc chỉ 1 hóa đơn (giữ nguyên logic cũ)
    BEGIN
        DECLARE @currentMaHoaDonMulti INT;
        DECLARE @tenNhanVienMulti NVARCHAR(255), @tenKhachHangMulti NVARCHAR(255), 
                @soPhongMulti NVARCHAR(50), @ngayXuatHoaDonMulti DATETIME, 
                @tongTienMulti DECIMAL(18,2), @trangThaiHoaDonMulti NVARCHAR(50),
                @maDatPhongMulti INT;

        DECLARE hoaDonCursorMulti CURSOR FOR 
        SELECT maHoaDon FROM #HoaDonList ORDER BY maHoaDon;

        OPEN hoaDonCursorMulti;
        FETCH NEXT FROM hoaDonCursorMulti INTO @currentMaHoaDonMulti;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Lấy thông tin chính của hóa đơn hiện tại
            SELECT 
                @tenNhanVienMulti = (SELECT TOP 1 ISNULL(tenNhanVien, N'Chưa chỉ định') FROM ChiTietHoaDon WHERE maHoaDon = @currentMaHoaDonMulti),
                @tenKhachHangMulti = kh.hoTen,
                @soPhongMulti = p.soPhong,
                @ngayXuatHoaDonMulti = h.ngayXuatHoaDon,
                @tongTienMulti = h.tongTien,
                @trangThaiHoaDonMulti = tth.tenTrangThai,
                @maDatPhongMulti = dp.maDatPhong
            FROM HoaDon h
            JOIN DatPhong dp ON h.maDatPhong = dp.maDatPhong
            JOIN KhachHang kh ON dp.maKhachHang = kh.maKhachHang
            JOIN Phong p ON dp.maPhong = p.maPhong
            JOIN TrangThaiHoaDon tth ON h.maTrangThaiHoaDon = tth.maTrangThaiHoaDon
            WHERE h.maHoaDon = @currentMaHoaDonMulti;

            SET @grandTotal = @grandTotal + @tongTienMulti; -- Cộng dồn tổng tiền

            -- Chèn thông tin tiêu đề cho hóa đơn hiện tại
            INSERT INTO #InvoiceLines VALUES (N'HÓA ĐƠN SỐ: ' + CAST(@currentMaHoaDonMulti AS NVARCHAR(10)));
            INSERT INTO #InvoiceLines VALUES (N'------------------------');
            INSERT INTO #InvoiceLines VALUES (N'Nhân viên: ' + ISNULL(@tenNhanVienMulti, N'Chưa chỉ định'));
            INSERT INTO #InvoiceLines VALUES (N'Khách hàng: ' + @tenKhachHangMulti);
            INSERT INTO #InvoiceLines VALUES (N'Số phòng: ' + @soPhongMulti);
            INSERT INTO #InvoiceLines VALUES (N'Ngày xuất hóa đơn: ' + CONVERT(NVARCHAR(20), @ngayXuatHoaDonMulti, 103));
            INSERT INTO #InvoiceLines VALUES (N'Trạng thái: ' + @trangThaiHoaDonMulti);
            INSERT INTO #InvoiceLines VALUES (N'------------------------');
            INSERT INTO #InvoiceLines VALUES (N'Chi tiết:');

            -- Chèn các mục chi tiết từ ChiTietHoaDon
            INSERT INTO #InvoiceLines
            SELECT 
                N'  - ' + loaiItem + N': ' + tenItem + N' | SL: ' + 
                CAST(ISNULL(soLuong, 1) AS NVARCHAR(10)) + N' | Đơn giá: ' + 
                FORMAT(giaTien, 'N0', 'vi-VN') + N' | Thành tiền: ' + 
                FORMAT(thanhTien, 'N0', 'vi-VN') +
                CASE WHEN ISNULL(ghiChu, '') <> '' THEN N' | Ghi chú: ' + ghiChu ELSE '' END
            FROM ChiTietHoaDon
            WHERE maHoaDon = @currentMaHoaDonMulti;

            -- Chèn các dịch vụ đã đặt
            INSERT INTO #InvoiceLines
            SELECT 
                N'  - Dịch vụ: ' + dv.tenDichVu + N' | SL: ' + 
                CAST(dvdp.soLuong AS NVARCHAR(10)) + N' | Đơn giá: ' + 
                FORMAT(dv.giaDichVu, 'N0', 'vi-VN') + N' | Thành tiền: ' + 
                FORMAT((dv.giaDichVu * dvdp.soLuong), 'N0', 'vi-VN')
            FROM DichVuDatPhong dvdp
            JOIN DichVu dv ON dvdp.maDichVu = dv.maDichVu
            WHERE dvdp.maDatPhong = @maDatPhongMulti;

            -- Chèn các khuyến mãi đã sử dụng
            INSERT INTO #InvoiceLines
            SELECT 
                N'  - Khuyến mãi: ' + km.tenKhuyenMai + N' | Giảm: ' + 
                FORMAT(sdkm.soTienGiam, 'N0', 'vi-VN')
            FROM SuDungKhuyenMai sdkm
            JOIN KhuyenMai km ON sdkm.maKhuyenMai = km.maKhuyenMai
            WHERE sdkm.maDatPhong = @maDatPhongMulti;

            -- Chèn tổng tiền cho hóa đơn hiện tại
            INSERT INTO #InvoiceLines VALUES (N'------------------------');
            INSERT INTO #InvoiceLines VALUES (N'Tổng tiền hóa đơn ' + CAST(@currentMaHoaDonMulti AS NVARCHAR(10)) + N': ' + FORMAT(@tongTienMulti, 'N0', 'vi-VN'));
            INSERT INTO #InvoiceLines VALUES (N'========================');
            INSERT INTO #InvoiceLines VALUES (N''); -- Dòng trống

            FETCH NEXT FROM hoaDonCursorMulti INTO @currentMaHoaDonMulti;
        END;

        CLOSE hoaDonCursorMulti;
        DEALLOCATE hoaDonCursorMulti;

        -- Chèn tổng cộng của tất cả hóa đơn đã xử lý (nếu có nhiều hóa đơn)
        IF (SELECT COUNT(*) FROM #HoaDonList) > 1
        BEGIN
             INSERT INTO #InvoiceLines VALUES (N'TỔNG CỘNG TẤT CẢ HÓA ĐƠN: ' + FORMAT(@grandTotal, 'N0', 'vi-VN'));
             INSERT INTO #InvoiceLines VALUES (N'========================');
        END
    END

    -- Trả về kết quả
    SELECT DisplayLine AS [Hóa đơn chi tiết] 
    FROM #InvoiceLines;

    -- Dọn dẹp
    DROP TABLE #InvoiceLines;
    DROP TABLE #HoaDonList;
END;
GO -- Thêm GO ở đây để kết thúc batch định nghĩa procedure

-- Ví dụ gọi thủ tục với 2 hóa đơn của cùng khách hàng 1
EXEC inrachitiethoadonplus @maHoaDonList = '1,7';

-- Ví dụ gọi thủ tục với 2 hóa đơn của khách hàng khác nhau
EXEC inrachitiethoadonplus @maHoaDonList = '1,2';



----------------
-- Trigger đơn giản để cập nhật trạng thái phòng khi đặt phòng
CREATE TRIGGER tr_CapNhatTrangThaiPhong
ON DatPhong
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE p
    SET p.maTrangThaiPhong = 
        CASE 
            WHEN i.maTrangThaiDatPhong = 1 THEN 2 -- Đã xác nhận -> Đã đặt
            WHEN i.maTrangThaiDatPhong = 4 THEN 3 -- Đang thuê -> Đang sử dụng
            WHEN i.maTrangThaiDatPhong = 5 THEN 6 -- Đã trả phòng -> Chờ dọn dẹp
            WHEN i.maTrangThaiDatPhong = 3 THEN 1 -- Đã hủy -> Trống
            ELSE p.maTrangThaiPhong
        END
    FROM Phong p
    JOIN inserted i ON p.maPhong = i.maPhong
END;

-- Trigger để tạo chi tiết hóa đơn cho tiền phòng
CREATE TRIGGER tr_TaoChiTietHoaDon
ON HoaDon
AFTER INSERT
AS
BEGIN
    -- Lấy mã chi tiết hóa đơn lớn nhất
    DECLARE @maxChiTietID INT
    SELECT @maxChiTietID = ISNULL(MAX(maChiTietHoaDon), 0) FROM ChiTietHoaDon
    
    -- Thêm chi tiết hóa đơn cho tiền phòng
    INSERT INTO ChiTietHoaDon (
        maChiTietHoaDon,
        maHoaDon,
        loaiItem,
        tenItem,
        soLuong,
        giaTien,
        thanhTien,
        soPhong,
        maKhachHang,
        ghiChu
    )
    SELECT 
        @maxChiTietID + 1,
        i.maHoaDon,
        'Phong',
        p.soPhong,
        DATEDIFF(DAY, dp.ngayNhanPhong, dp.ngayTraPhong), -- Số đêm
        p.giaMoiDem,
        DATEDIFF(DAY, dp.ngayNhanPhong, dp.ngayTraPhong) * p.giaMoiDem, -- Thành tiền
        p.soPhong,
        dp.maKhachHang,
        'Tiền phòng'
    FROM inserted i
    JOIN DatPhong dp ON i.maDatPhong = dp.maDatPhong
    JOIN Phong p ON dp.maPhong = p.maPhong
    
    -- Cập nhật tổng tiền của hóa đơn
    UPDATE h
    SET tongTien = (
        SELECT SUM(thanhTien)
        FROM ChiTietHoaDon
        WHERE maHoaDon = h.maHoaDon
    )
    FROM HoaDon h
    JOIN inserted i ON h.maHoaDon = i.maHoaDon
END;
--hiển thị trạng thái phòng hiên tại--
    SELECT p.maPhong, p.soPhong, tp.tenTrangThai 
    FROM Phong p 
    JOIN TrangThaiPhong tp ON p.maTrangThaiPhong = tp.maTrangThaiPhong
--đặt một phòng mới--
    INSERT INTO DatPhong (maDatPhong, maKhachHang, maPhong, ngayNhanPhong, ngayTraPhong, maTrangThaiDatPhong, loaiDatPhong, soNguoiLon, soTreEm)
    VALUES (7, 1, 3, '2025-05-01 14:00:00', '2025-05-03 12:00:00', 1, 'Online', 2, 1)
--kiểm tra lại trạng thái phòng--
 SELECT p.maPhong, p.soPhong, tp.tenTrangThai 
    FROM Phong p 
    JOIN TrangThaiPhong tp ON p.maTrangThaiPhong = tp.maTrangThaiPhong
    WHERE p.maPhong = 3
--hủy phòng--
 UPDATE DatPhong SET maTrangThaiDatPhong = 3 WHERE maDatPhong = 7
--kiểm tra lại trạng thái phòng--
 SELECT p.maPhong, p.soPhong, tp.tenTrangThai 
    FROM Phong p 
    JOIN TrangThaiPhong tp ON p.maTrangThaiPhong = tp.maTrangThaiPhong
    WHERE p.maPhong = 3
--kiểm tra chi tiết hóa đơn hiện có--
SELECT * FROM ChiTietHoaDon
--tạo môt hóa đơn mới--
    INSERT INTO HoaDon (maHoaDon, maDatPhong, ngayXuatHoaDon, tongTien, maTrangThaiHoaDon)
    VALUES (7, 2, GETDATE(), 0, 2)
--kiểm tra chi tiết hóa đơn tạo tự động--
 SELECT * FROM ChiTietHoaDon WHERE maHoaDon = 7
--kiểm tra tổng tiền hóa đơn đã được cập nhật--
 SELECT * FROM HoaDon WHERE maHoaDon = 7
        

------hàm in ra các procedure dư
		SELECT SCHEMA_NAME(schema_id) AS SchemaName, name AS ProcedureName
        FROM sys.procedures
        ORDER BY SchemaName, ProcedureName;


-----hàm in ra các trigger hiện có 
        SELECT
            SCHEMA_NAME(o.schema_id) AS SchemaName,
            o.name AS TriggerName,
            OBJECT_SCHEMA_NAME(parent_object_id) AS ParentSchemaName,
            OBJECT_NAME(parent_object_id) AS ParentTableName
        FROM sys.triggers t
        JOIN sys.objects o ON t.object_id = o.object_id
        ORDER BY SchemaName, ParentTableName, TriggerName;



-----xóa procedure 
    DROP PROCEDURE dbo.TenProcedure;

----xóa trigger

    DROP TRIGGER TenSchema.TenTrigger;



