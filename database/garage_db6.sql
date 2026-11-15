-- =============================================================
-- CSDL he thong quan ly gara - garage_db6 (De 30 - B23DCVT346)
-- Chay toan bo file nay trong MySQL Workbench (Ctrl+Shift+Enter)
-- =============================================================
SET NAMES utf8mb4;
DROP DATABASE IF EXISTS garage_db6;
CREATE DATABASE garage_db6 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE garage_db6;

-- ---------------- Nhom con nguoi ----------------
CREATE TABLE tblSystemMember6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(50) NOT NULL,
  name VARCHAR(100),
  phone VARCHAR(15),
  email VARCHAR(100),
  address VARCHAR(255),
  dob DATE,
  role VARCHAR(30)            -- CUSTOMER | MANAGEMENT | SALE | WAREHOUSE | TECHNICAL
);

CREATE TABLE tblCustomer6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  customerCode VARCHAR(20),
  tblSystemMember6id INT(10) NOT NULL,
  FOREIGN KEY (tblSystemMember6id) REFERENCES tblSystemMember6(id)
);

CREATE TABLE tblStaff6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  staffCode VARCHAR(20),
  position VARCHAR(50),
  tblSystemMember6id INT(10) NOT NULL,
  FOREIGN KEY (tblSystemMember6id) REFERENCES tblSystemMember6(id)
);

CREATE TABLE tblManagementStaff6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  tblStaff6id INT(10) NOT NULL,
  FOREIGN KEY (tblStaff6id) REFERENCES tblStaff6(id)
);
CREATE TABLE tblSaleStaff6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  tblStaff6id INT(10) NOT NULL,
  FOREIGN KEY (tblStaff6id) REFERENCES tblStaff6(id)
);
CREATE TABLE tblWarehouseStaff6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  tblStaff6id INT(10) NOT NULL,
  FOREIGN KEY (tblStaff6id) REFERENCES tblStaff6(id)
);
CREATE TABLE tblTechnicalStaff6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  tblStaff6id INT(10) NOT NULL,
  FOREIGN KEY (tblStaff6id) REFERENCES tblStaff6(id)
);

-- ---------------- Nhom nghiep vu ----------------
CREATE TABLE tblVehicle6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  licensePlate VARCHAR(20),
  vehicleType VARCHAR(50),
  brand VARCHAR(50),
  model VARCHAR(50),
  tblCustomer6id INT(10) NOT NULL,
  FOREIGN KEY (tblCustomer6id) REFERENCES tblCustomer6(id)
);

CREATE TABLE tblAppointment6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  appointmentCode VARCHAR(20),
  appointmentDate DATETIME,
  status VARCHAR(30),
  tblVehicle6id INT(10) NOT NULL,
  FOREIGN KEY (tblVehicle6id) REFERENCES tblVehicle6(id)
);

CREATE TABLE tblReception6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  receptionCode VARCHAR(20),
  checkInTime DATETIME,
  status VARCHAR(30),
  tblVehicle6id INT(10) NOT NULL,
  tblAppointment6id INT(10) NULL,          -- NULL = khach vang lai
  tblSaleStaff6id INT(10) NOT NULL,
  FOREIGN KEY (tblVehicle6id) REFERENCES tblVehicle6(id),
  FOREIGN KEY (tblAppointment6id) REFERENCES tblAppointment6(id),
  FOREIGN KEY (tblSaleStaff6id) REFERENCES tblSaleStaff6(id)
);

CREATE TABLE tblService6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  serviceCode VARCHAR(20),
  name VARCHAR(100),
  description VARCHAR(255),
  price DECIMAL(12,2),
  status VARCHAR(30),
  supportedVehicleType VARCHAR(100),
  warrantyPeriod INT(10)
);

CREATE TABLE tblSparePart6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  partCode VARCHAR(20),
  name VARCHAR(100),
  description VARCHAR(255),
  price DECIMAL(12,2),
  stock INT(10),
  supportedVehicleType VARCHAR(100),
  warrantyPeriod INT(10)
);

CREATE TABLE tblInvoice6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  invoiceCode VARCHAR(20),
  createdDate DATETIME,
  totalAmount DECIMAL(12,2),
  tblReception6id INT(10) NOT NULL UNIQUE, -- 1 phieu tiep nhan -> toi da 1 hoa don
  FOREIGN KEY (tblReception6id) REFERENCES tblReception6(id)
);

CREATE TABLE tblServiceDetail6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  quantity INT(10),
  unitPrice DECIMAL(12,2),
  subTotal DECIMAL(12,2),
  tblInvoice6id INT(10) NOT NULL,
  tblService6id INT(10) NOT NULL,
  tblTechnicalStaff6id INT(10) NOT NULL,
  FOREIGN KEY (tblInvoice6id) REFERENCES tblInvoice6(id) ON DELETE CASCADE,
  FOREIGN KEY (tblService6id) REFERENCES tblService6(id),
  FOREIGN KEY (tblTechnicalStaff6id) REFERENCES tblTechnicalStaff6(id)
);

CREATE TABLE tblSparePartDetail6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  quantity INT(10),
  unitPrice DECIMAL(12,2),
  subTotal DECIMAL(12,2),
  tblInvoice6id INT(10) NOT NULL,
  tblSparePart6id INT(10) NOT NULL,
  FOREIGN KEY (tblInvoice6id) REFERENCES tblInvoice6(id) ON DELETE CASCADE,
  FOREIGN KEY (tblSparePart6id) REFERENCES tblSparePart6(id)
);

CREATE TABLE tblSupplier6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  supplierCode VARCHAR(20),
  name VARCHAR(100),
  address VARCHAR(255),
  phone VARCHAR(15),
  email VARCHAR(100)
);

CREATE TABLE tblImportInvoice6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  importCode VARCHAR(20),
  importDate DATETIME,
  totalAmount DECIMAL(12,2),
  tblSupplier6id INT(10) NOT NULL,
  tblWarehouseStaff6id INT(10) NOT NULL,
  FOREIGN KEY (tblSupplier6id) REFERENCES tblSupplier6(id),
  FOREIGN KEY (tblWarehouseStaff6id) REFERENCES tblWarehouseStaff6(id)
);

CREATE TABLE tblImportDetail6 (
  id INT(10) AUTO_INCREMENT PRIMARY KEY,
  quantity INT(10),
  unitPrice DECIMAL(12,2),
  subTotal DECIMAL(12,2),
  tblImportInvoice6id INT(10) NOT NULL,
  tblSparePart6id INT(10) NOT NULL,
  FOREIGN KEY (tblImportInvoice6id) REFERENCES tblImportInvoice6(id) ON DELETE CASCADE,
  FOREIGN KEY (tblSparePart6id) REFERENCES tblSparePart6(id)
);

-- =============================================================
-- DU LIEU MAU (khop voi kich ban trong bao cao)
-- Mat khau tat ca tai khoan: 123
-- =============================================================
INSERT INTO tblSystemMember6 (id, username, password, name, phone, email, address, dob, role) VALUES
 (1, 'kh1',   '123', 'Cao Văn B',      '0123456789', 'caovanb@gmail.com',  'Hà Đông, Hà Nội',  '1995-04-12', 'CUSTOMER'),
 (2, 'kh2',   '123', 'Đặng Văn L',     '0988888888', 'dangvanl@gmail.com', 'Cầu Giấy, Hà Nội', '1990-09-01', 'CUSTOMER'),
 (3, 'kh3',   '123', 'Nguyễn Thị H',   '0912345678', 'nguyenthih@gmail.com','Thanh Xuân, Hà Nội','1998-02-20', 'CUSTOMER'),
 (4, 'ql1',   '123', 'Đặng Trần Minh Quân', '0901000001', 'quanly@garage.vn',   'Hà Nội',           '1985-06-15', 'MANAGEMENT'),
 (5, 'kt1',   '123', 'Nguyễn Văn T',   '0901000002', 'kt01@garage.vn',     'Hà Nội',           '1992-03-03', 'TECHNICAL'),
 (6, 'kt2',   '123', 'Lê Văn K',       '0901000003', 'kt02@garage.vn',     'Hà Nội',           '1994-07-07', 'TECHNICAL'),
 (7, 'bh1',   '123', 'Phạm Thị S',     '0901000004', 'bh01@garage.vn',     'Hà Nội',           '1997-11-11', 'SALE'),
 (8, 'kho1', '123', 'Hoàng Văn W',    '0901000005', 'kho01@garage.vn',    'Hà Nội',           '1993-05-05', 'WAREHOUSE');

INSERT INTO tblCustomer6 (id, customerCode, tblSystemMember6id) VALUES
 (1, 'KH018', 1), (2, 'KH036', 2), (3, 'KH050', 3);

INSERT INTO tblStaff6 (id, staffCode, position, tblSystemMember6id) VALUES
 (1, 'QL01', 'Nhân viên quản lý', 4),
 (2, 'KT01', 'Nhân viên kỹ thuật', 5),
 (3, 'KT02', 'Nhân viên kỹ thuật', 6),
 (4, 'BH01', 'Nhân viên bán hàng', 7),
 (5, 'KHO01','Nhân viên kho', 8);

INSERT INTO tblManagementStaff6 (id, tblStaff6id) VALUES (1, 1);
INSERT INTO tblTechnicalStaff6  (id, tblStaff6id) VALUES (1, 2), (2, 3);
INSERT INTO tblSaleStaff6       (id, tblStaff6id) VALUES (1, 4);
INSERT INTO tblWarehouseStaff6  (id, tblStaff6id) VALUES (1, 5);

INSERT INTO tblVehicle6 (id, licensePlate, vehicleType, brand, model, tblCustomer6id) VALUES
 (1, '29A-123.45', 'Ô tô', 'Toyota',  'Vios 2020',  1),
 (2, '30G-678.90', 'Ô tô', 'Honda',   'City 2021',  2),
 (3, '29H-111.22', 'Ô tô', 'Hyundai', 'Accent 2019',3);

INSERT INTO tblAppointment6 (id, appointmentCode, appointmentDate, status, tblVehicle6id) VALUES
 (1, 'LH001', '2026-05-01 08:00:00', 'Đã đến', 1),
 (2, 'LH002', '2026-03-15 09:00:00', 'Đã đến', 2);

INSERT INTO tblReception6 (id, receptionCode, checkInTime, status, tblVehicle6id, tblAppointment6id, tblSaleStaff6id) VALUES
 (1, 'TN001', '2026-05-01 08:05:00', 'Hoàn thành', 1, 1,    1),
 (2, 'TN002', '2026-06-02 10:00:00', 'Hoàn thành', 1, NULL, 1),
 (3, 'TN003', '2026-03-15 09:10:00', 'Hoàn thành', 2, 2,    1),
 (4, 'TN004', '2026-06-20 14:00:00', 'Hoàn thành', 2, NULL, 1),
 (5, 'TN005', '2025-12-10 08:30:00', 'Hoàn thành', 3, NULL, 1),
 (6, 'TN006', '2026-06-25 15:00:00', 'Hoàn thành', 3, NULL, 1);

INSERT INTO tblService6 (id, serviceCode, name, description, price, status, supportedVehicleType, warrantyPeriod) VALUES
 (1, 'DV105', 'Thay dầu động cơ',            'Thay dầu nhớt động cơ, kiểm tra rò rỉ',           500000,   'Khả dụng',        'Mọi dòng xe',          3),
 (2, 'DV200', 'Thay má phanh sedan hạng B',  'Tháo lắp, thay má phanh, vệ sinh cụm phanh',      200000,   'Khả dụng',        'Vios, Accent, City',   3),
 (3, 'DV300', 'Bảo dưỡng định kỳ',           'Bảo dưỡng định kỳ theo km, kiểm tra 30 hạng mục', 1500000,  'Khả dụng',        'Mọi dòng xe',          6),
 (4, 'DV400', 'Sơn toàn thân',               'Sơn lại toàn bộ thân xe',                         20000000, 'Khả dụng',        'Sedan, Hatchback',     12),
 (5, 'DV500', 'Đại tu hộp số',               'Đại tu hộp số tự động',                           10000000, 'Khả dụng',        'Mọi dòng xe',          12),
 (6, 'DV600', 'Cân chỉnh thước lái',         'Cân chỉnh hệ thống lái',                          300000,   'Ngừng cung cấp',  'Mọi dòng xe',          1);

INSERT INTO tblSparePart6 (id, partCode, name, description, price, stock, supportedVehicleType, warrantyPeriod) VALUES
 (1, 'PT100', 'Má phanh trước Toyota Vios', 'Phụ tùng chính hãng OEM',   850000,  15, 'Toyota Vios 2018-2022', 12),
 (2, 'PT101', 'Má phanh sau Toyota Vios',   'Phụ tùng chính hãng OEM',   650000,  0,  'Toyota Vios 2014-2017', 12),
 (3, 'PT110', 'Ắc quy GS 45Ah',             'Ắc quy khô, bảo hành 12 tháng', 1000000, 20, 'Sedan hạng B',       12),
 (4, 'PT120', 'Cản trước Honda City',       'Cản trước nhựa ABS',        4000000, 3,  'Honda City 2020-2023',  6),
 (5, 'PT130', 'Lọc gió động cơ',            'Lọc gió giấy',              350000,  40, 'Mọi dòng xe',           3),
 (6, 'PT205', 'Lốp Michelin',               'Lốp Michelin 185/60R15',    2500000, 12, 'Sedan hạng B',          24);

-- Hoa don ban (Cao Van B: 15.500.000 | Dang Van L: 36.000.000 | Nguyen Thi H: 1.200.000 trong ky + 1 HD ngoai ky)
INSERT INTO tblInvoice6 (id, invoiceCode, createdDate, totalAmount, tblReception6id) VALUES
 (1, 'HD10024', '2026-05-01 11:00:00', 8000000,  1),
 (2, 'HD10067', '2026-06-02 16:00:00', 7500000,  2),
 (3, 'HD10050', '2026-03-15 17:00:00', 24000000, 3),
 (4, 'HD10080', '2026-06-20 17:30:00', 12000000, 4),
 (5, 'HD09001', '2025-12-10 11:00:00', 3000000,  5),
 (6, 'HD10095', '2026-06-25 17:00:00', 1200000,  6);

-- tblTechnicalStaff6id: 1 = Nguyen Van T (KT01), 2 = Le Van K (KT02)
INSERT INTO tblServiceDetail6 (quantity, unitPrice, subTotal, tblInvoice6id, tblService6id, tblTechnicalStaff6id) VALUES
 (1, 500000,   500000,   1, 1, 1),
 (1, 1500000,  1500000,  2, 3, 2),
 (1, 20000000, 20000000, 3, 4, 1),
 (1, 10000000, 10000000, 4, 5, 2),
 (1, 1500000,  1500000,  5, 3, 1),
 (1, 500000,   500000,   6, 1, 2);

INSERT INTO tblSparePartDetail6 (quantity, unitPrice, subTotal, tblInvoice6id, tblSparePart6id) VALUES
 (3, 2500000, 7500000, 1, 6),
 (2, 2500000, 5000000, 2, 6),
 (1, 1000000, 1000000, 2, 3),
 (1, 4000000, 4000000, 3, 4),
 (2, 1000000, 2000000, 4, 3),
 (1, 1500000, 1500000, 5, 4),
 (2, 350000,  700000,  6, 5);

INSERT INTO tblSupplier6 (id, supplierCode, name, address, phone, email) VALUES
 (1, 'NCC01', 'Công ty Phụ tùng Toyota VN', 'Long Biên, Hà Nội', '0243000001', 'sales@pttoyota.vn'),
 (2, 'NCC02', 'Michelin Việt Nam',          'Quận 7, TP.HCM',    '0283000002', 'info@michelin.vn');

INSERT INTO tblImportInvoice6 (id, importCode, importDate, totalAmount, tblSupplier6id, tblWarehouseStaff6id) VALUES
 (1, 'PN001', '2026-04-01 09:00:00', 18000000, 1, 1);
INSERT INTO tblImportDetail6 (quantity, unitPrice, subTotal, tblImportInvoice6id, tblSparePart6id) VALUES
 (20, 600000, 12000000, 1, 1),
 (10, 600000, 6000000,  1, 2);
