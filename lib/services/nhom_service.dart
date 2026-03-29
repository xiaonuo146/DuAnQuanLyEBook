import '../database/database_helper.dart';
import '../models/sach.dart';

class NhomService {

  final dbHelper = DatabaseHelper();

  // tạo nhóm

  Future<void> taoNhom(String tenNhom) async {

    final db = await dbHelper.database;

    await db.insert(
      'nhom',
      {
        'tenNhom': tenNhom,
      },
    );
  }

  // lấy danh sách nhóm

  Future<List<Map<String, dynamic>>> layDanhSachNhom() async {

    final db = await dbHelper.database;

    return await db.query('nhom');
  }

  // thêm sách vào nhóm

  Future<void> themSachVaoNhom(int bookId, int nhomId) async {

    final db = await dbHelper.database;

    await db.insert(
      'sach_nhom',
      {
        'bookId': bookId,
        'nhomId': nhomId,
      },
    );
  }

  // lấy sách theo nhóm

  Future<List<Sach>> laySachTheoNhom(int nhomId) async {

    final db = await dbHelper.database;

    final result = await db.rawQuery('''
      SELECT sach.*
      FROM sach
      INNER JOIN sach_nhom
      ON sach.id = sach_nhom.bookId
      WHERE sach_nhom.nhomId = ?
    ''', [nhomId]);

    return result.map((e) => Sach.fromMap(e)).toList();
  }
}