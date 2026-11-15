"""Sinh du lieu mo rong cho garage_db6 (~1000 san pham + giao dich 2025-2026).
Gia la gia tham khao thi truong VN (lam tron), khong phai bao gia chinh thuc."""
import random, datetime
random.seed(30346)

def q(s): return "'" + str(s).replace("'", "''") + "'"
def r1k(x): return int(round(x / 1000.0)) * 1000
def r10k(x): return int(round(x / 10000.0)) * 10000

# ---------------- Dong xe pho bien tai VN ----------------
# (hang, dong, doi, phan khuc, nhien lieu, co_tai_lop)
MODELS = [
 ("Toyota","Vios","2018-2023","B","xang","185/60R15"),
 ("Toyota","Corolla Cross","2020-2024","CSUV","xang","215/60R17"),
 ("Toyota","Innova","2016-2023","MPV","xang","205/65R16"),
 ("Toyota","Fortuner","2017-2024","DSUV","dau","265/65R17"),
 ("Toyota","Camry","2019-2024","D","xang","235/45R18"),
 ("Toyota","Veloz Cross","2022-2024","MPV","xang","205/50R17"),
 ("Toyota","Raize","2021-2024","ASUV","xang","205/60R17"),
 ("Hyundai","Accent","2018-2024","B","xang","185/65R15"),
 ("Hyundai","Grand i10","2017-2024","A","xang","165/65R14"),
 ("Hyundai","Creta","2022-2024","BSUV","xang","215/60R17"),
 ("Hyundai","Tucson","2019-2024","CSUV","xang","225/55R18"),
 ("Hyundai","Santa Fe","2019-2024","DSUV","dau","235/55R19"),
 ("Kia","Morning","2016-2023","A","xang","175/50R15"),
 ("Kia","Seltos","2020-2024","BSUV","xang","215/55R18"),
 ("Kia","K3","2019-2024","C","xang","225/45R17"),
 ("Kia","Sonet","2021-2024","ASUV","xang","215/60R16"),
 ("Kia","Carnival","2021-2024","MPVL","dau","235/60R18"),
 ("Mazda","Mazda3","2019-2024","C","xang","215/45R18"),
 ("Mazda","CX-5","2018-2024","CSUV","xang","225/55R19"),
 ("Honda","City","2020-2024","B","xang","185/55R16"),
 ("Honda","CR-V","2018-2024","CSUV","xang","235/60R18"),
 ("Honda","Civic","2019-2024","C","xang","215/50R17"),
 ("Mitsubishi","Xpander","2018-2024","MPV","xang","205/55R17"),
 ("Mitsubishi","Attrage","2017-2023","A","xang","185/55R15"),
 ("Ford","Ranger","2018-2024","PICKUP","dau","255/70R16"),
 ("Ford","Everest","2018-2024","DSUV","dau","255/60R20"),
 ("Ford","Territory","2022-2024","CSUV","xang","235/50R19"),
 ("VinFast","Fadil","2019-2022","A","xang","185/55R15"),
 ("VinFast","Lux A2.0","2019-2022","D","xang","245/45R19"),
 ("Suzuki","XL7","2020-2024","MPV","xang","195/60R16"),
]
SEG_K = {"A":0.8,"ASUV":0.9,"B":1.0,"BSUV":1.1,"C":1.25,"CSUV":1.35,"MPV":1.15,"MPVL":1.7,"D":1.7,"DSUV":1.8,"PICKUP":1.6}
SEG_CLASS = {"A":"Xe hạng A","ASUV":"Sedan hạng B","B":"Sedan hạng B","BSUV":"SUV/Crossover cỡ C",
             "C":"Sedan hạng C","CSUV":"SUV/Crossover cỡ C","MPV":"MPV 7 chỗ","MPVL":"SUV 7 chỗ / Bán tải",
             "D":"Sedan hạng C","DSUV":"SUV 7 chỗ / Bán tải","PICKUP":"SUV 7 chỗ / Bán tải"}

# ---------------- Loai phu tung theo dong xe ----------------
# (ten, gia co so hang B, bao hanh thang, cac hang aftermarket, chi_xang)
PART_TYPES = [
 ("Má phanh trước", 750000, 12, ["Bendix","Akebono","Brembo"], False),
 ("Má phanh sau", 600000, 12, ["Bendix","Akebono"], False),
 ("Đĩa phanh trước", 1200000, 12, ["Brembo","Bosch"], False),
 ("Lọc dầu động cơ", 120000, 3, ["Bosch","VIC","Denso"], False),
 ("Lọc gió động cơ", 250000, 3, ["Bosch","Denso","Sakura"], False),
 ("Lọc gió điều hòa", 220000, 3, ["Bosch","Denso"], False),
 ("Lọc nhiên liệu", 450000, 6, ["Bosch","Denso"], False),
 ("Bugi Iridium (bộ 4)", 1100000, 12, ["Denso","NGK"], True),
 ("Cuộn đánh lửa", 950000, 12, ["Denso","Bosch"], True),
 ("Giảm xóc trước", 1600000, 12, ["KYB","Monroe"], False),
 ("Giảm xóc sau", 1300000, 12, ["KYB","Monroe"], False),
 ("Rotuyn lái ngoài", 450000, 6, ["555","CTR"], False),
 ("Cao su chân máy", 900000, 6, ["Sankei","CTR"], False),
 ("Dây curoa tổng", 550000, 12, ["Gates","Bando"], False),
 ("Bơm nước", 1400000, 12, ["Aisin","GMB"], False),
 ("Két nước làm mát", 2600000, 12, ["Denso","Koyorad"], False),
 ("Quạt két nước", 1800000, 12, ["Denso"], False),
 ("Đèn pha (1 bên)", 4500000, 6, ["Depo","TYC"], False),
 ("Gương chiếu hậu (1 bên)", 2200000, 6, ["Depo"], False),
 ("Cản trước", 3500000, 6, ["Hàng tháo xe"], False),
 ("Cảm biến oxy", 1900000, 12, ["Denso","Bosch"], True),
 ("Bi moay ơ trước", 900000, 12, ["NSK","Koyo","SKF"], False),
 ("Gạt mưa (cặp)", 350000, 3, ["Bosch","Denso"], False),
 ("Lốc điều hòa", 9500000, 12, ["Denso","Sanden"], False),
 ("Củ đề (mô tơ khởi động)", 4200000, 12, ["Denso","Bosch"], False),
 ("Máy phát điện", 6500000, 12, ["Denso","Bosch"], False),
 ("Bơm nhiên liệu", 2400000, 12, ["Denso","Bosch"], False),
 ("Thước lái", 12000000, 12, ["JTEKT","TRW"], False),
 ("Cao su chụp bụi láp", 350000, 6, ["555","Sankei"], False),
]
SKIP = {("Má phanh trước","Toyota","Vios"),("Má phanh sau","Toyota","Vios"),("Cản trước","Honda","City")}

parts = []   # dict
def add_part(name, desc, price, stock, vtype, warranty, model_key=None):
    parts.append(dict(name=name, desc=desc, price=price, stock=stock, vtype=vtype, warranty=warranty, model=model_key))

def rand_stock():
    return 0 if random.random() < 0.06 else random.randint(1, 40)

for brand, model, years, seg, fuel, tire in MODELS:
    k = SEG_K[seg]
    for (tname, base, war, makers, petrol_only) in PART_TYPES:
        if petrol_only and fuel == "dau": continue
        if (tname, brand, model) in SKIP: continue
        oem = random.random() < 0.45
        maker = brand if oem else random.choice(makers)
        price = r10k(base * k * (1.25 if oem else 1.0) * random.uniform(0.9, 1.1))
        desc = (f"Phụ tùng chính hãng {brand} (OEM)" if oem else f"Hàng thay thế thương hiệu {maker}")
        add_part(f"{tname} {brand} {model}", desc, price, rand_stock(), f"{brand} {model} {years}", war + (6 if oem and war >= 12 else 0), (brand, model))

# Lop xe theo kich co thuc te
tire_sizes = sorted({m[5] for m in MODELS})
tire_price = lambda s: r10k(1100000 + (int(s.split('R')[1]) - 14) * 450000 + (int(s.split('/')[0]) - 165) * 9000)
for size in tire_sizes:
    users = ", ".join(f"{m[0]} {m[1]}" for m in MODELS if m[5] == size)
    for tb, km in (("Michelin", 1.25), ("Bridgestone", 1.1), ("Kumho", 0.85)):
        add_part(f"Lốp {tb} {size}", f"Lốp {tb} chính hãng, cỡ {size}", r10k(tire_price(size) * km), rand_stock(), users[:100], 24 if tb != "Kumho" else 12)

# Dau nhot, dung dich
OILS = [("Dầu nhớt Castrol Magnatec 10W-40 4L", 690000), ("Dầu nhớt Castrol EDGE 5W-30 4L", 1150000),
        ("Dầu nhớt Shell Helix HX7 10W-40 4L", 640000), ("Dầu nhớt Shell Helix Ultra 5W-40 4L", 1090000),
        ("Dầu nhớt Mobil 1 0W-20 4L", 1290000), ("Dầu nhớt Mobil Super 3000 5W-30 4L", 890000),
        ("Dầu nhớt Toyota Genuine 0W-20 4L", 980000), ("Dầu nhớt Total Quartz 9000 5W-40 4L", 950000),
        ("Dầu nhớt Castrol Vecton 15W-40 diesel 6L", 990000), ("Dầu nhớt Shell Rimula R4 15W-40 diesel 6L", 920000),
        ("Dầu hộp số tự động Toyota ATF WS 4L", 1100000), ("Dầu hộp số Castrol Transmax ATF 4L", 880000),
        ("Dầu phanh Bosch DOT4 1L", 210000), ("Nước làm mát Toyota Super Long Life 4L", 520000),
        ("Nước làm mát Prestone 50/50 3.78L", 360000), ("Dung dịch vệ sinh kim phun Liqui Moly 300ml", 290000),
        ("Dung dịch vệ sinh họng ga Wurth 500ml", 230000), ("Gas điều hòa R134a (bình 1kg)", 450000)]
for n, p in OILS:
    add_part(n, "Hàng chính hãng, có tem nhà phân phối", p, rand_stock(), "Mọi dòng xe (theo khuyến cáo nhà sản xuất)", 0 if "Dầu" in n or "Dung dịch" in n or "Gas" in n or "Nước" in n else 6)

# Ac quy
BATS = [("GS", "MF 40B19L 35Ah", 1150000), ("GS", "MF 55D23L 60Ah", 1750000), ("GS", "MF 95D31L 80Ah", 2450000),
        ("Varta", "Silver Dynamic 45Ah", 1650000), ("Varta", "Blue Dynamic 60Ah", 2050000), ("Varta", "AGM 70Ah", 4200000),
        ("Amaron", "Pro 38B20L 35Ah", 1250000), ("Amaron", "Hi-Life 55D23L 60Ah", 1850000),
        ("Rocket", "SMF 55B24LS 45Ah", 1350000), ("Rocket", "SMF 90D26L 70Ah", 2150000),
        ("Bosch", "S4 60Ah", 2100000), ("Delkor", "DIN 60Ah", 1950000)]
for b, m, p in BATS:
    add_part(f"Ắc quy {b} {m}", f"Ắc quy khô {b}, bảo hành chính hãng", p, rand_stock(), "Theo dung lượng khuyến cáo của xe", 12 if b != "Varta" else 18)

# Phu kien / do choi
ACC = [("Bóng đèn Philips H4 X-tremeVision (cặp)", 450000), ("Bóng đèn Osram H11 Night Breaker (cặp)", 520000),
       ("Bóng đèn LED Philips Ultinon H4 (cặp)", 1650000), ("Camera hành trình Vietmap C61", 3290000),
       ("Camera hành trình 70mai A500S", 2390000), ("Cảm biến áp suất lốp TPMS Steelmate", 1890000),
       ("Thảm lót sàn 5D", 1500000), ("Phim cách nhiệt 3M Crystalline (bộ xe 5 chỗ)", 9500000),
       ("Phim cách nhiệt Llumar (bộ xe 5 chỗ)", 5500000), ("Bọc vô lăng da", 450000),
       ("Màn hình Android Zestech Z800", 9900000), ("Nước rửa kính Sonax 2L", 120000)]
for n, p in ACC:
    add_part(n, "Phụ kiện chính hãng nhà phân phối", p, rand_stock(), "Mọi dòng xe", 12)

# ---------------- Dich vu theo nhom xe ----------------
CLASSES = ["Xe hạng A", "Sedan hạng B", "Sedan hạng C", "SUV/Crossover cỡ C", "MPV 7 chỗ", "SUV 7 chỗ / Bán tải"]
CLASS_K = [0.85, 1.0, 1.2, 1.3, 1.2, 1.5]
CLASS_EX = {"Xe hạng A":"Morning, Grand i10, Fadil, Attrage", "Sedan hạng B":"Vios, Accent, City",
            "Sedan hạng C":"Mazda3, K3, Civic", "SUV/Crossover cỡ C":"Corolla Cross, CR-V, CX-5, Tucson",
            "MPV 7 chỗ":"Xpander, Innova, Veloz Cross, XL7", "SUV 7 chỗ / Bán tải":"Fortuner, Everest, Santa Fe, Ranger"}
SVCS = [("Bảo dưỡng cấp nhỏ 5.000 km", 600000, 1, "Thay dầu, kiểm tra 20 hạng mục"),
        ("Bảo dưỡng cấp trung 10.000 km", 1200000, 1, "Thay dầu, lọc dầu, vệ sinh lọc gió, kiểm tra phanh"),
        ("Bảo dưỡng cấp trung lớn 20.000 km", 2200000, 3, "Gồm cấp 10.000 km + thay lọc gió, lọc điều hòa"),
        ("Bảo dưỡng cấp lớn 40.000 km", 4500000, 6, "Thay dầu hộp số, nước làm mát, dầu phanh, bugi"),
        ("Thay dầu hộp số tự động", 800000, 3, "Xả và thay dầu ATF bằng máy"),
        ("Thay nước làm mát", 450000, 3, "Súc rửa két nước, thay nước làm mát"),
        ("Thay dầu phanh", 400000, 3, "Xả e và thay dầu phanh DOT4"),
        ("Vệ sinh kim phun và buồng đốt", 1200000, 1, "Vệ sinh bằng máy chuyên dụng"),
        ("Vệ sinh họng ga", 450000, 1, "Tháo vệ sinh, cài lại cầm chừng"),
        ("Vệ sinh dàn lạnh điều hòa", 900000, 3, "Nội soi, vệ sinh dàn lạnh không tháo táp lô"),
        ("Nạp gas điều hòa", 500000, 3, "Hút chân không, nạp gas R134a"),
        ("Cân chỉnh độ chụm bánh xe", 350000, 1, "Cân chỉnh 3D Hunter"),
        ("Cân bằng động 4 bánh", 200000, 1, "Cân bằng lốp trên máy"),
        ("Đảo lốp", 100000, 0, "Đảo lốp theo sơ đồ"),
        ("Thay má phanh trước", 250000, 3, "Công thay má phanh, vệ sinh cụm phanh"),
        ("Láng đĩa phanh", 400000, 3, "Láng đĩa phanh trên máy"),
        ("Kiểm tra và thay ắc quy", 100000, 0, "Đo CCA, thay ắc quy, reset hệ thống"),
        ("Chẩn đoán lỗi bằng máy", 300000, 0, "Đọc lỗi OBD-II, tư vấn sửa chữa"),
        ("Phủ ceramic", 6000000, 24, "Hiệu chỉnh sơn và phủ ceramic 9H"),
        ("Đánh bóng toàn xe", 1500000, 1, "Đánh bóng 3 bước, xóa xước nhẹ"),
        ("Sơn cản trước", 1800000, 12, "Sơn gốc 2K, sấy buồng"),
        ("Sơn một cánh cửa", 1600000, 12, "Sơn gốc 2K, pha màu theo mã sơn"),
        ("Gò hàn móp méo", 800000, 6, "Gò nắn, xử lý móp nhẹ"),
        ("Rửa xe và hút bụi", 120000, 0, "Rửa xe bọt tuyết, hút bụi nội thất"),
        ("Vệ sinh nội thất", 1500000, 1, "Vệ sinh ghế, trần, sàn, khử mùi"),
        ("Dán phim cách nhiệt (công)", 900000, 0, "Công dán phim toàn xe")]
services = []
for (sname, base, war, desc) in SVCS:
    for cls, ck in zip(CLASSES, CLASS_K):
        if sname == "Thay má phanh trước" and cls == "Sedan hạng B":  # trung DV200
            continue
        status = "Ngừng cung cấp" if random.random() < 0.03 else "Khả dụng"
        services.append(dict(name=f"{sname} - {cls}", desc=desc, price=r10k(base * ck), status=status,
                             vtype=f"{cls} ({CLASS_EX[cls]})", warranty=war, cls=cls))

# ---------------- Nguoi ----------------
HO = ["Nguyễn","Trần","Lê","Phạm","Hoàng","Huỳnh","Phan","Vũ","Võ","Đặng","Bùi","Đỗ","Hồ","Ngô","Dương","Lý"]
DEM_NAM = ["Văn","Minh","Đức","Quang","Hữu","Thành","Tuấn","Mạnh","Công","Xuân"]
DEM_NU = ["Thị","Thu","Ngọc","Thanh","Phương","Hồng","Mai"]
TEN_NAM = ["An","Bình","Cường","Dũng","Hải","Hiếu","Hùng","Khánh","Long","Nam","Phong","Quý","Sơn","Thắng","Trung","Tùng","Việt","Vinh"]
TEN_NU = ["Anh","Chi","Dung","Hà","Hạnh","Hoa","Lan","Linh","Ly","Nga","Nhung","Thảo","Trang","Vân","Yến"]
QUAN = ["Hà Đông","Cầu Giấy","Thanh Xuân","Đống Đa","Hoàng Mai","Long Biên","Nam Từ Liêm","Bắc Từ Liêm","Hai Bà Trưng","Ba Đình","Tây Hồ","Thanh Trì"]
def ten():
    if random.random() < 0.65: return f"{random.choice(HO)} {random.choice(DEM_NAM)} {random.choice(TEN_NAM)}"
    return f"{random.choice(HO)} {random.choice(DEM_NU)} {random.choice(TEN_NU)}"
def phone(): return "09" + "".join(random.choice("0123456789") for _ in range(8))

members, customers, staff = [], [], []
mid, cid, sid = 8, 3, 5
# them nhan vien ky thuat, ban hang
tech_ids, sale_ids = [1, 2], [1]
techs, sales = [], []
for i in range(4):
    mid += 1; sid += 1
    n = ten(); members.append((mid, f"kt{i+3}", "123", n, phone(), f"kt{i+3}@garage.vn", "Hà Nội", f"199{random.randint(0,9)}-0{random.randint(1,9)}-1{random.randint(0,9)}", "TECHNICAL"))
    staff.append((sid, f"KT0{i+3}", "Nhân viên kỹ thuật", mid)); techs.append((len(tech_ids)+1, sid)); tech_ids.append(len(tech_ids)+1)
mid += 1; sid += 1
members.append((mid, "bh2", "123", ten(), phone(), "bh2@garage.vn", "Hà Nội", "1998-08-08", "SALE"))
staff.append((sid, "BH02", "Nhân viên bán hàng", mid)); sales.append((2, sid)); sale_ids.append(2)

NEW_CUST = 57
for i in range(NEW_CUST):
    mid += 1; cid += 1
    n = ten()
    members.append((mid, f"kh{cid}", "123", n, phone(), f"kh{cid}@gmail.com", f"{random.choice(QUAN)}, Hà Nội",
                    f"19{random.randint(70,99)}-{random.randint(1,12):02d}-{random.randint(1,28):02d}", "CUSTOMER"))
    customers.append((cid, f"KH{100+cid:03d}", mid))

# ---------------- Xe ----------------
vehicles = []
vid = 3
PLATE_PRE = ["29A","30A","30E","30F","30G","30H","30K","29H","30L"]
for (cid_, code, _) in customers:
    for _ in range(1 if random.random() < 0.75 else 2):
        vid += 1
        m = random.choice(MODELS)
        year = random.randint(int(m[2][:4]), int(m[2][-4:]))
        plate = f"{random.choice(PLATE_PRE)}-{random.randint(100,999)}.{random.randint(10,99)}"
        vehicles.append(dict(id=vid, plate=plate, vtype="Ô tô", brand=m[0], model=f"{m[1]} {year}", cust=cid_, mk=(m[0], m[1]), seg=m[3]))

# ---------------- Giao dich ----------------
part_by_model = {}
universal_parts = []
for idx, p in enumerate(parts):
    p["id"] = 7 + idx
    if p["model"]: part_by_model.setdefault(p["model"], []).append(p)
    else: universal_parts.append(p)
for idx, s in enumerate(services):
    s["id"] = 7 + idx
svc_by_class = {}
for s in services:
    if s["status"] == "Khả dụng": svc_by_class.setdefault(s["cls"], []).append(s)

appts, recs, invs, sdet, pdet = [], [], [], [], []
aid, rid, iid = 2, 6, 6
start = datetime.datetime(2025, 1, 2); end = datetime.datetime(2026, 11, 10)
span = (end - start).days
H1_START, H1_END = datetime.datetime(2026,1,1), datetime.datetime(2026,6,30,23,59)
h1_total = {}
for v in vehicles:
    for _ in range(random.randint(2, 6)):
        d = start + datetime.timedelta(days=random.randint(0, span), hours=random.randint(8, 16), minutes=random.choice([0,15,30,45]))
        cls = SEG_CLASS[v["seg"]]
        svc_list = random.sample(svc_by_class[cls], k=min(len(svc_by_class[cls]), random.choice([1,1,2,2,3])))
        mp = part_by_model.get(v["mk"], [])
        pl = [p for p in random.sample(mp, k=min(len(mp), random.choice([0,1,1,2,3]))) if p["stock"] > 0]
        if random.random() < 0.35:
            pl.append(random.choice([p for p in universal_parts if p["stock"] > 0]))
        lines_s = [(1, s["price"], s) for s in svc_list]
        lines_p = []
        for p in pl:
            qty = 4 if p["name"].startswith("Lốp") and random.random() < 0.5 else (2 if p["name"].startswith("Lốp") else 1)
            lines_p.append((qty, p["price"], p))
        total = sum(q_*u for q_,u,_ in lines_s) + sum(q_*u for q_,u,_ in lines_p)
        # giu dung kich ban bao cao: khach moi trong 01/01-30/06/2026 khong vuot 14,5 trieu
        if H1_START <= d <= H1_END:
            if h1_total.get(v["cust"], 0) + total > 14500000:
                d = d.replace(year=2025)
            else:
                h1_total[v["cust"]] = h1_total.get(v["cust"], 0) + total
        appt = None
        if random.random() < 0.45:
            aid += 1; appt = aid
            appts.append((aid, f"LH{aid:04d}", (d - datetime.timedelta(minutes=10)).strftime("%Y-%m-%d %H:%M:%S"), "Đã đến", v["id"]))
        rid += 1
        recs.append((rid, f"TN{rid:04d}", d.strftime("%Y-%m-%d %H:%M:%S"), "Hoàn thành", v["id"], appt, random.choice(sale_ids)))
        iid += 1
        inv_d = d + datetime.timedelta(hours=random.randint(1, 4))
        invs.append((iid, f"HD{20000+iid}", inv_d.strftime("%Y-%m-%d %H:%M:%S"), total, rid))
        for q_, u, s in lines_s: sdet.append((q_, u, q_*u, iid, s["id"], random.choice(tech_ids)))
        for q_, u, p in lines_p: pdet.append((q_, u, q_*u, iid, p["id"]))

# ---------------- Nha cung cap, nhap kho ----------------
SUPS = [("NCC03","Bosch Việt Nam","Quận 7, TP.HCM","0283000003","sales@vn.bosch.com"),
        ("NCC04","Denso Việt Nam","Thăng Long, Hà Nội","0243000004","sales@denso.com.vn"),
        ("NCC05","Castrol BP Petco","Quận 1, TP.HCM","0283000005","info@castrol.vn"),
        ("NCC06","Ắc quy GS Việt Nam","Biên Hòa, Đồng Nai","0251300006","sales@gsbattery.vn"),
        ("NCC07","KYB Việt Nam","Vĩnh Phúc","0211300007","sales@kyb.com.vn"),
        ("NCC08","Hyundai Thành Công (phụ tùng)","Ninh Bình","0229300008","parts@hyundai.tc.vn")]
imports, idet = [], []
imp_id = 1
for m in range(24):
    d = datetime.datetime(2025, 1, 5) + datetime.timedelta(days=30*m + random.randint(0, 10), hours=9)
    if d > end: break
    imp_id += 1
    chosen = random.sample(parts, k=random.randint(5, 12))
    tot = 0
    for p in chosen:
        qty = random.randint(5, 30); unit = r1k(p["price"] * random.uniform(0.6, 0.75))
        idet.append((qty, unit, qty*unit, imp_id, p["id"])); tot += qty*unit
    imports.append((imp_id, f"PN{imp_id:03d}", d.strftime("%Y-%m-%d %H:%M:%S"), tot, random.randint(1, 2 + len(SUPS)), 1))

# ---------------- Xuat SQL ----------------
out = []
def ins(table, cols, rows, chunk=200):
    for i in range(0, len(rows), chunk):
        out.append(f"INSERT INTO {table} ({', '.join(cols)}) VALUES")
        vals = []
        for r in rows[i:i+chunk]:
            vals.append(" (" + ", ".join("NULL" if x is None else (str(x) if isinstance(x, (int, float)) else q(x)) for x in r) + ")")
        out.append(",\n".join(vals) + ";")
out.append("\n-- =============================================================")
out.append("-- DU LIEU MO RONG (sinh tu dong): ~1000 san pham + giao dich 2025-2026")
out.append("-- Gia la gia tham khao thi truong VN (lam tron), chi phuc vu hoc tap.")
out.append("-- Khong lam thay doi ket qua kich ban trong bao cao (KH036, KH018 van dung dau ky 01/01-30/06/2026).")
out.append("-- =============================================================")
ins("tblSystemMember6", ["id","username","password","name","phone","email","address","dob","role"], members)
ins("tblCustomer6", ["id","customerCode","tblSystemMember6id"], customers)
ins("tblStaff6", ["id","staffCode","position","tblSystemMember6id"], staff)
ins("tblTechnicalStaff6", ["id","tblStaff6id"], techs)
ins("tblSaleStaff6", ["id","tblStaff6id"], sales)
ins("tblService6", ["id","serviceCode","name","description","price","status","supportedVehicleType","warrantyPeriod"],
    [(s["id"], f"DV{3000+i+1}", s["name"], s["desc"], s["price"], s["status"], s["vtype"], s["warranty"]) for i, s in enumerate(services)])
ins("tblSparePart6", ["id","partCode","name","description","price","stock","supportedVehicleType","warrantyPeriod"],
    [(p["id"], f"PT{3000+i+1}", p["name"], p["desc"], p["price"], p["stock"], p["vtype"], p["warranty"]) for i, p in enumerate(parts)])
ins("tblVehicle6", ["id","licensePlate","vehicleType","brand","model","tblCustomer6id"],
    [(v["id"], v["plate"], v["vtype"], v["brand"], v["model"], v["cust"]) for v in vehicles])
ins("tblAppointment6", ["id","appointmentCode","appointmentDate","status","tblVehicle6id"], appts)
ins("tblReception6", ["id","receptionCode","checkInTime","status","tblVehicle6id","tblAppointment6id","tblSaleStaff6id"], recs)
ins("tblInvoice6", ["id","invoiceCode","createdDate","totalAmount","tblReception6id"], invs)
ins("tblServiceDetail6", ["quantity","unitPrice","subTotal","tblInvoice6id","tblService6id","tblTechnicalStaff6id"], sdet)
ins("tblSparePartDetail6", ["quantity","unitPrice","subTotal","tblInvoice6id","tblSparePart6id"], pdet)
ins("tblSupplier6", ["id","supplierCode","name","address","phone","email"], [(3+i,)+s for i, s in enumerate(SUPS)])
ins("tblImportInvoice6", ["id","importCode","importDate","totalAmount","tblSupplier6id","tblWarehouseStaff6id"], imports)
ins("tblImportDetail6", ["quantity","unitPrice","subTotal","tblImportInvoice6id","tblSparePart6id"], idet)

base = open("/tmp/gen2/base.sql", encoding="utf-8").read().rstrip() + "\n"
open("/tmp/gen2/garage_db6.sql", "w", encoding="utf-8").write(base + "\n".join(out) + "\n")
print("parts", len(parts)+6, "services", len(services)+6, "total products", len(parts)+len(services)+12)
print("customers", len(customers)+3, "vehicles", len(vehicles)+3, "invoices", len(invs)+6, "svc lines", len(sdet), "part lines", len(pdet), "imports", len(imports)+1)
