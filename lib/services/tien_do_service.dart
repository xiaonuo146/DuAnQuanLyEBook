import '../database/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/ghi_chu.dart';
class TienDoService {

  final dbHelper = DatabaseHelper();

  Future<void> luuTrang(int bookId, int trang) async {

    final db = await dbHelper.database;

    await db.insert(
      'tien_do_doc',
      {
        'bookId': bookId,
        'trang': trang,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> layTrang(int bookId) async {

    final db = await dbHelper.database;

    final result = await db.query(
      'tien_do_doc',
      where: 'bookId=?',
      whereArgs: [bookId],
    );

    if (result.isNotEmpty) {
      return result.first['trang'] as int;
    }

    return 0;
  }
      Future<void> themGhiChu(GhiChu ghiChu) async {
       final db = await dbHelper.database;
      await db.insert(  'ghi_chu',  ghiChu.toMap(),
         );
      }
}