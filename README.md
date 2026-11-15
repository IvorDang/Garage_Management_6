# Garage Management System 6

Hệ thống quản lý gara ô tô xây dựng bằng **Java Web (JSP + DAO) + MySQL**, chạy trên **Apache Tomcat 10.1**.
Đồ án học phần **Phân tích và thiết kế hệ thống thông tin** – Học viện Công nghệ Bưu chính Viễn thông (PTIT), **Đề 30**.

| | |
|---|---|
| Sinh viên | Đặng Trần Minh Quân – B23DCVT346 – E23CNPM01 – Nhóm 01 |
| Giảng viên hướng dẫn | Đỗ Thị Bích Ngọc |
| Công nghệ | Java 17 · JSP (Jakarta EE) · JDBC · MySQL 8 · Apache Tomcat 10.1 · Maven |

---

## Mục lục

1. [Giới thiệu](#1-giới-thiệu)
2. [Chức năng đã cài đặt](#2-chức-năng-đã-cài-đặt)
3. [Kiến trúc hệ thống](#3-kiến-trúc-hệ-thống)
4. [Cơ sở dữ liệu](#4-cơ-sở-dữ-liệu)
5. [Cài đặt và chạy](#5-cài-đặt-và-chạy)
6. [Demo giao diện](#6-demo-giao-diện)
7. [Tài liệu phân tích – thiết kế (UML)](#7-tài-liệu-phân-tích--thiết-kế-uml)
8. [Cấu trúc thư mục](#8-cấu-trúc-thư-mục)
9. [Phạm vi và hạn chế](#9-phạm-vi-và-hạn-chế)

---

## 1. Giới thiệu

Hệ thống hỗ trợ một gara bảo dưỡng ô tô quản lý dịch vụ, phụ tùng, khách hàng, phương tiện, tiếp nhận xe, hóa đơn và nhập kho. Có 4 nhóm người dùng: **khách hàng, nhân viên bán hàng, nhân viên kho và nhân viên quản lý**.

Theo yêu cầu đề bài, dự án cài đặt chi tiết **2 module**:

| Module | Người dùng | Mô tả |
|---|---|---|
| **1. Customer searches for service information** | Khách hàng (không cần đăng nhập) | Tìm dịch vụ/phụ tùng theo tên, xem chi tiết giá, tình trạng, dòng xe hỗ trợ, bảo hành |
| **2. Management staff views customer statistics** | Nhân viên quản lý (bắt buộc đăng nhập) | Thống kê khách hàng theo doanh thu trong một khoảng thời gian → xem hóa đơn của khách → xem chi tiết hóa đơn |

## 2. Chức năng đã cài đặt

**Module 1 – Tìm kiếm dịch vụ/phụ tùng**
- Trang chủ khách hàng mở được khi chưa đăng nhập (khách vãng lai).
- Tìm theo tên có chứa từ khóa, không phân biệt hoa thường hay có dấu/không dấu. Kết quả gộp cả phụ tùng và dịch vụ.
- Xem chi tiết: mã, tên, đơn giá, tình trạng/tồn kho, dòng xe hỗ trợ, bảo hành, mô tả.
- Xử lý ngoại lệ: ô tìm kiếm trống, không tìm thấy, phụ tùng hết hàng, dịch vụ ngừng cung cấp.

**Module 2 – Thống kê khách hàng theo doanh thu**
- Đăng nhập. Các trang quản lý kiểm tra phiên làm việc (session); chưa đăng nhập thì chuyển về trang đăng nhập.
- Chọn khoảng thời gian, xem danh sách khách hàng xếp theo tổng doanh thu giảm dần.
- Chọn khách hàng để xem danh sách hóa đơn trong kỳ, chọn hóa đơn để xem chi tiết (bảng dịch vụ kèm thợ thực hiện, bảng phụ tùng).
- Xử lý ngoại lệ: bỏ trống ngày, ngày không tồn tại, ngày bắt đầu lớn hơn ngày kết thúc, kỳ không có dữ liệu.

**Dùng chung:** đăng nhập/đăng xuất theo vai trò (CUSTOMER, MANAGEMENT). Các chức năng ngoài phạm vi (đặt lịch, quản lý dịch vụ…) hiển thị thông báo *"Chức năng đang phát triển"*.

## 3. Kiến trúc hệ thống

Ứng dụng web 3 tầng theo mô hình **JSP – DAO – Model**:

```
Trình duyệt ──HTTP──► Tomcat 10.1 ──JDBC──► MySQL 8 (garage_db6)
                       │
                       ├─ view  (JSP)   : giao diện + điều hướng
                       ├─ dao   (Java)  : truy vấn CSDL, đóng gói thực thể
                       └─ model (Java)  : lớp thực thể
```

- **Quy ước đặt tên trang:** `gd…` là trang **giao diện** (có hiển thị). `do…` là trang **xử lý** (nhận dữ liệu, gọi DAO rồi chuyển trang).
- **Hậu tố `6`** trên mọi lớp, bảng và trang là quy ước đánh số của đề.
- `DAO6` là lớp cha giữ kết nối JDBC; các DAO con kế thừa để dùng chung.

| Tầng | Thành phần |
|---|---|
| view / thanhvien | `gdDangNhap6.jsp`, `doDangNhap6.jsp`, `doDangXuat6.jsp` |
| view / khachhang | `gdChinhKH6.jsp`, `gdTimKiem6.jsp`, `gdChiTiet6.jsp` |
| view / quanly | `gdChinhQL6.jsp`, `gdChonThongKe6.jsp`, `gdKetQuaThongKe6.jsp`, `gdDSHoaDon6.jsp`, `gdChiTietHoaDon6.jsp` |
| dao | `DAO6`, `SystemMemberDAO6`, `ServiceDAO6`, `SparePartDAO6`, `CustomerStatisticDAO6`, `InvoiceDAO6` |
| model | `SystemMember6`, `Customer6`, `Staff6`, `ManagementStaff6`, `TechnicalStaff6`, `Service6`, `SparePart6`, `Invoice6`, `ServiceDetail6`, `SparePartDetail6`, `CustomerStatistic6` |

![Package diagram](docs/uml/19_Package.png)

## 4. Cơ sở dữ liệu

Schema `garage_db6` gồm **18 bảng**. Bảng kế thừa được tách theo lớp: `tblSystemMember6` → `tblCustomer6`, `tblStaff6` → 4 bảng nhân viên. File `database/garage_db6.sql` tạo toàn bộ bảng và dữ liệu mẫu khớp với kịch bản trong báo cáo.

**Dữ liệu mở rộng** (cuối file SQL, sinh bởi `database/gen_data6.py`, seed cố định): **981 phụ tùng + 161 dịch vụ (~1.140 sản phẩm)**, 60 khách hàng, 71 xe, 270 hóa đơn (01/2025 – 11/2026), 24 phiếu nhập kho, 8 nhà cung cấp. Phụ tùng theo 30 dòng xe phổ biến ở Việt Nam (Vios, Accent, City, Xpander, CX-5, Ranger, Fadil…), lốp theo cỡ thực tế (Michelin/Bridgestone/Kumho), dầu nhớt, ắc quy GS/Varta/Amaron…; giá là giá tham khảo thị trường, làm tròn, chỉ phục vụ học tập. Dữ liệu mở rộng không làm đổi kết quả kịch bản báo cáo: kỳ 01/01–30/06/2026 vẫn là KH036 (36 triệu) rồi KH018 (15,5 triệu).

Ví dụ từ khóa để thử: `má phanh`, `lốp michelin`, `ắc quy`, `bảo dưỡng`, `Xpander`, `Ranger`.

Doanh thu của khách hàng được tính theo chuỗi quan hệ:

```
tblCustomer6 → tblVehicle6 → tblReception6 → tblInvoice6   (SUM totalAmount, GROUP BY khách hàng)
```

![Thiết kế CSDL](docs/uml/12_CSDL.png)

## 5. Cài đặt và chạy

### 5.1. Yêu cầu

| Phần mềm | Phiên bản |
|---|---|
| JDK | 17 trở lên |
| MySQL Server + MySQL Workbench | 8.x |
| Apache Tomcat | **10.1.x** (không dùng Tomcat 9 vì dự án dùng chuẩn Jakarta) |
| Apache Maven | 3.8 trở lên |
| IDE (tùy chọn) | VS Code + *Extension Pack for Java* (+ *Community Server Connectors*) |

### 5.2. Tạo CSDL

1. Mở **MySQL Workbench**, kết nối tài khoản `root`.
2. Vào **File → Open SQL Script…**, chọn `database/garage_db6.sql`, rồi bấm ⚡ **Execute**.
3. Kiểm tra bằng câu lệnh `SELECT * FROM garage_db6.tblSparePart6;`. Tiếng Việt hiển thị đúng là đã thành công.

### 5.3. Cấu hình kết nối

Mở `src/main/java/dao/DAO6.java` và sửa mật khẩu MySQL của máy bạn:

```java
con = DriverManager.getConnection(dbUrl, "root", "root"); // tham số thứ 3 = mật khẩu MySQL
```

Driver `mysql-connector-j` đã khai báo trong `pom.xml`, Maven tự tải về và đóng vào file `.war`.

### 5.4. Build và chạy lần đầu

Các lệnh dưới đây chạy trong **PowerShell** (terminal của VS Code), tại thư mục gốc dự án. Hãy sửa 3 đường dẫn ở bước 1 cho đúng với máy bạn.

```powershell
# 1) Khai báo đường dẫn (chạy lại mỗi khi mở terminal mới)
$env:JAVA_HOME = "$HOME\.jdks\openjdk-25.0.2"    # JDK 17+ (không dùng Java 8)
$MVN    = "C:\apache-maven-3.9.16\bin\mvn.cmd"
$TOMCAT = "C:\apache-tomcat-10.1.61"
$env:CATALINA_HOME = $TOMCAT                      # startup.bat / shutdown.bat cần biến này

# 2) Lấy mã nguồn (CHỈ khi máy chưa có dự án; nếu đã có thì chỉ cần cd vào thư mục gốc chứa pom.xml)
git clone https://github.com/IvorDang/Garage_Management_6.git
cd Garage_Management_6

# 3) Build ra target\GarageManagement.war
& $MVN clean package

# 4) Deploy lên Tomcat và bật server
Copy-Item target\GarageManagement.war "$TOMCAT\webapps\" -Force
& "$TOMCAT\bin\startup.bat"
```

Mở trình duyệt tại **http://localhost:8080/GarageManagement/**. Tomcat mở thêm một cửa sổ console. Đừng đóng cửa sổ này khi đang demo.

> Kiểm tra nhanh: `java -version` phải là 17 trở lên sau khi đặt `JAVA_HOME`. `& $MVN -v` phải in ra phiên bản Maven.

### 5.5. Tắt / mở server

| Việc | Lệnh (PowerShell) |
|---|---|
| Bật Tomcat | `& "$TOMCAT\bin\startup.bat"` |
| Tắt Tomcat | `& "$TOMCAT\bin\shutdown.bat"` (hoặc đóng cửa sổ console Tomcat) |
| Kiểm tra cổng 8080 | `netstat -ano \| findstr :8080` |
| Tắt tiến trình chiếm cổng 8080 | `taskkill /PID <PID> /F` (PID là cột cuối của lệnh trên) |
| Bật / tắt MySQL | `net start MySQL80` / `net stop MySQL80` (chạy PowerShell **Run as Administrator**), hoặc dùng `services.msc` |

Tomcat cần MySQL đang chạy. Thông thường MySQL tự khởi động cùng Windows.

### 5.6. Cập nhật sau khi sửa code

Mỗi lần sửa file `.java`, `.jsp` hoặc `.css`, phải build và deploy lại thì Tomcat mới chạy bản mới:

```powershell
& "$TOMCAT\bin\shutdown.bat"
& $MVN clean package
Remove-Item "$TOMCAT\webapps\GarageManagement" -Recurse -Force -ErrorAction SilentlyContinue   # xóa bản giải nén cũ
Copy-Item target\GarageManagement.war "$TOMCAT\webapps\" -Force
& "$TOMCAT\bin\startup.bat"
```

Sau đó mở lại trang và bấm **Ctrl + F5** để trình duyệt không dùng bản đã lưu (cache).

**Cập nhật CSDL** (khi `database/garage_db6.sql` thay đổi): mở file trong Workbench, rồi bấm ⚡ **Execute**. Script tự `DROP` và tạo lại `garage_db6`, nên không cần restart Tomcat. Chỉ cần tải lại trang.

**Lấy code mới từ GitHub:** chạy `git pull`, rồi làm các bước ở mục 5.6 này.

> Không commit mật khẩu MySQL thật. Trước khi `git push`, chạy `git checkout -- src/main/java/dao/DAO6.java` để trả file về mặc định, hoặc đừng stage file đó.

> Chạy trong VS Code: ở panel **SERVERS** (Community Server Connectors), thêm Tomcat tại `$TOMCAT`. Sau đó chuột phải chọn **Add Deployment**, trỏ tới `target/GarageManagement.war`, rồi chọn **Start Server** / **Stop Server**.

### 5.7. Tài khoản demo

| Vai trò | Tên đăng nhập | Mật khẩu | Ghi chú |
|---|---|---|---|
| Nhân viên quản lý | `ql1` | `123` | Đặng Trần Minh Quân |
| Khách hàng | `kh1` | `123` | Cao Văn B (KH018) |
| Khách vãng lai | — | — | Không cần tài khoản để tìm kiếm |

### 5.8. Lỗi thường gặp

| Lỗi | Cách sửa |
|---|---|
| `Access denied for user 'root'` | Sai mật khẩu trong `DAO6.java` |
| `Communications link failure` | MySQL chưa chạy: mở `services.msc` rồi Start **MySQL80** |
| `ClassNotFoundException: com.mysql.cj.jdbc.Driver` | Chưa build bằng Maven (hoặc chưa có jar trong `WEB-INF/lib`) |
| 404 toàn bộ / lỗi `javax.servlet` | Đang dùng Tomcat 9: đổi sang Tomcat 10.1 |
| Tiếng Việt lỗi font | Chạy lại toàn bộ file SQL (đầu file đã có `SET NAMES utf8mb4`) |
| `mvn` / `startup.bat` *is not recognized* | Gọi bằng đường dẫn đầy đủ như mục 5.4 (`& $MVN …`, `& "$TOMCAT\bin\startup.bat"`) |
| `invalid target release: 17` / build lỗi do Java 8 | Chưa đặt `$env:JAVA_HOME` sang JDK 17+ trong terminal hiện tại |
| `The CATALINA_HOME environment variable is not defined correctly` | Chạy `$env:CATALINA_HOME = $TOMCAT` (đường dẫn Tomcat phải đúng, kiểm tra bằng `Test-Path "$TOMCAT\bin\startup.bat"`) |
| Build xong nhưng không có `target\GarageManagement.war` | Terminal không đứng ở thư mục gốc chứa `pom.xml` (vd. đang ở trong bản clone thừa) |
| `Address already in use: 8080` | Tomcat cũ còn chạy: chạy `shutdown.bat` hoặc `taskkill` (mục 5.5) |
| Sửa code nhưng web không đổi | Chưa build/deploy lại hoặc trình duyệt dùng cache: làm theo mục 5.6, rồi bấm Ctrl+F5 |

## 6. Demo giao diện

### Module 1 – Khách hàng tìm kiếm dịch vụ/phụ tùng

| Trang chủ khách hàng (chưa đăng nhập) | Kết quả tìm "má phanh" |
|---|---|
| ![](docs/screenshots/01_trang_chu_khach.png) | ![](docs/screenshots/02_tim_kiem.png) |

| Chi tiết phụ tùng PT100 | Phụ tùng hết hàng (PT101) |
|---|---|
| ![](docs/screenshots/05_chi_tiet_phu_tung.png) | ![](docs/screenshots/06_het_hang.png) |

| Dịch vụ ngừng cung cấp (DV600) | Ô tìm kiếm trống | Không tìm thấy |
|---|---|---|
| ![](docs/screenshots/07_ngung_cung_cap.png) | ![](docs/screenshots/03_loi_o_trong.png) | ![](docs/screenshots/04_khong_tim_thay.png) |

### Đăng nhập

| Đặt lịch khi chưa đăng nhập | Sai mật khẩu | Truy cập trang quản lý khi chưa đăng nhập |
|---|---|---|
| ![](docs/screenshots/08_dang_nhap_yeu_cau.png) | ![](docs/screenshots/09_dang_nhap_sai.png) | ![](docs/screenshots/17_het_phien.png) |

### Module 2 – Quản lý xem thống kê khách hàng theo doanh thu

| Trang chủ quản lý | Chọn loại thống kê và thời gian |
|---|---|
| ![](docs/screenshots/10_trang_chu_quan_ly.png) | ![](docs/screenshots/11_chon_thong_ke.png) |

| Thống kê 01/01/2026 – 30/06/2026 | Danh sách hóa đơn của Cao Văn B |
|---|---|
| ![](docs/screenshots/14_ket_qua_thong_ke.png) | ![](docs/screenshots/15_ds_hoa_don.png) |

| Chi tiết hóa đơn HD10024 | Ngày bắt đầu lớn hơn ngày kết thúc | Kỳ không có dữ liệu |
|---|---|---|
| ![](docs/screenshots/16_chi_tiet_hoa_don.png) | ![](docs/screenshots/12_loi_ngay.png) | ![](docs/screenshots/13_khong_du_lieu.png) |

**Kịch bản demo nhanh**

1. Mở trang chủ, bấm *Tìm kiếm dịch vụ/phụ tùng*, nhập **má phanh**. Kết quả: PT100, PT101 đứng đầu, sau đó là má phanh của các dòng xe khác và DV200. Bấm *Xem chi tiết* PT100.
2. Bấm *Đặt lịch hẹn*, hệ thống yêu cầu đăng nhập. Đăng nhập **ql1 / 123**.
3. Vào *Xem báo cáo thống kê*, chọn **01/01/2026 – 30/06/2026** rồi bấm *Tìm kiếm*. Kết quả: Đặng Văn L 36.000.000, Cao Văn B 15.500.000, Nguyễn Thị H 1.200.000.
4. Bấm **Cao Văn B** để thấy HD10024 và HD10067. Bấm **HD10024** để xem chi tiết: thay dầu động cơ (thợ Nguyễn Văn T), 3 lốp Michelin, tổng 8.000.000.

## 7. Tài liệu phân tích – thiết kế (UML)

Mã nguồn PlantUML (`.puml`) và ảnh của 20 biểu đồ nằm trong [`docs/uml`](docs/uml). Bản in mỗi biểu đồ một trang A4: [`docs/uml/UML_TongHop_A4.pdf`](docs/uml/UML_TongHop_A4.pdf).

| Pha | Biểu đồ |
|---|---|
| Đặc tả | Use case tổng quan, Use case Module 1, Use case Module 2 |
| Phân tích | Lớp thực thể, lớp phân tích Module 1/2, trạng thái Module 1/2, giao tiếp Module 1/2 |
| Thiết kế | Lớp thực thể (thiết kế), CSDL, lớp thiết kế Module 1/2, sơ đồ hành vi Module 1/2, tuần tự Module 1/2, Package, Deployment |

| Use case tổng quan | Lớp thiết kế Module 2 |
|---|---|
| ![](docs/uml/01_UC_TongQuan.png) | ![](docs/uml/14_ThietKe_Module2.png) |

Xuất lại ảnh từ mã nguồn: cài extension **PlantUML** trong VS Code, hoặc chạy `java -jar plantuml.jar -Sdpi=220 docs/uml/*.puml`.

## 8. Cấu trúc thư mục

```
Garage_Management_6/
├── pom.xml                         # Maven: đóng gói WAR, driver mysql-connector-j
├── database/
│   └── garage_db6.sql              # tạo 18 bảng + dữ liệu mẫu
├── docs/
│   ├── screenshots/                # ảnh demo giao diện
│   └── uml/                        # 20 biểu đồ PlantUML (.puml + .png) + bản PDF A4
└── src/main/
    ├── java/
    │   ├── dao/                    # DAO6 + các lớp truy xuất dữ liệu
    │   └── model/                  # lớp thực thể
    └── webapp/
        ├── index.jsp               # chuyển tới trang chủ khách hàng
        ├── css/style.css
        ├── WEB-INF/web.xml
        ├── thanhvien/              # đăng nhập, đăng xuất
        ├── khachhang/              # Module 1
        └── quanly/                 # Module 2
```

## 9. Phạm vi và hạn chế

- Chỉ cài đặt 2 module theo đề. Các gói `banhang`, `kho` và chức năng đặt lịch thuộc thiết kế tổng thể, chưa cài đặt.
- Dự án chạy local phục vụ học tập: mật khẩu lưu dạng thường (có dùng `PreparedStatement` để chống SQL injection). Khi triển khai thật cần băm mật khẩu (ví dụ BCrypt) và dùng connection pool.
- Giao diện tối ưu cho trình duyệt trên máy tính; điện thoại vẫn truy cập được qua cùng địa chỉ web.

---

© 2026 Đặng Trần Minh Quân – PTIT. Dự án phục vụ mục đích học tập.
