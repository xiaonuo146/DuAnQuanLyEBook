import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await khoiTaoDatabase();
    return _database!;
  }

  Future<Database> khoiTaoDatabase() async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'eread.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        
        // =========================
        // BẢNG SÁCH
        // =========================
        await db.execute('''
        CREATE TABLE sach(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tieuDe TEXT,
          tacGia TEXT,
          theLoai TEXT,
          duongDanFile TEXT,
          ngayThem TEXT,
          yeuThich INTEGER
        )
        ''');

        // =========================
        // BẢNG TIẾN ĐỘ ĐỌC
        // =========================
        await db.execute('''
        CREATE TABLE tien_do_doc(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          bookId INTEGER UNIQUE,
          trang INTEGER
        )
        ''');

        // =========================
        // BẢNG NHÓM YÊU THÍCH
        // =========================
        await db.execute('''
        CREATE TABLE nhom(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          tenNhom TEXT
        )
        ''');

        // =========================
        // BẢNG SÁCH TRONG NHÓM
        // =========================
        await db.execute('''
        CREATE TABLE sach_nhom(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          bookId INTEGER,
          nhomId INTEGER
        )
        ''');
        // =========================
        // BẢNG GHI CHÚ GIỌNG NÓI
        // =========================
        await db.execute('''
        CREATE TABLE ghi_chu(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          bookId INTEGER,
          trang INTEGER,
          noiDung TEXT
        )
    ''');
      },
    );
  }

}