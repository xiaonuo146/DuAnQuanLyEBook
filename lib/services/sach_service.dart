import '../database/database_helper.dart';
import '../models/sach.dart';

class SachService {

  final dbHelper = DatabaseHelper();

  // =========================
  // THÊM SÁCH
  // =========================

  Future<void> themSach(Sach sach) async {

    final db = await dbHelper.database;

    await db.insert(
      'sach',
      sach.toMap(),
    );
  }

  // =========================
  // LẤY DANH SÁCH SÁCH
  // =========================

  Future<List<Sach>> layDanhSachSach() async {

    final db = await dbHelper.database;

    final result = await db.query('sach',orderBy: 'ngayThem DESC',);
    return result.map((e) => Sach.fromMap(e)).toList();
  }

  // =========================
  // XÓA SÁCH
  // =========================

  Future<void> xoaSach(int id) async {

    final db = await dbHelper.database;

    await db.delete(
      'sach',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  // =========================
  // CẬP NHẬT YÊU THÍCH ⭐
  // =========================

  Future<void> capNhatYeuThich(int id, int yeuThich) async {

    final db = await dbHelper.database;

    await db.update(
      'sach',
      {'yeuThich': yeuThich},
      where: 'id=?',
      whereArgs: [id],
    );
  }

  // =========================
  // TÌM KIẾM SÁCH
  // =========================

  Future<List<Sach>> timKiemSach(String keyword) async {

    final db = await dbHelper.database;

    final result = await db.query(
      'sach',
      where: '''
      tieuDe LIKE ?
      OR tacGia LIKE ?
      OR theLoai LIKE ?
      ''',
      whereArgs: [
        '%$keyword%',
        '%$keyword%',
        '%$keyword%'
      ],
    );

    return result.map((e) => Sach.fromMap(e)).toList();
  }

  // =========================
  // LẤY SÁCH YÊU THÍCH
  // =========================

  Future<List<Sach>> laySachYeuThich() async {

    final db = await dbHelper.database;

    final result = await db.query(
      'sach',
      where: 'yeuThich = 1',
    );

    return result.map((e) => Sach.fromMap(e)).toList();
  }
}