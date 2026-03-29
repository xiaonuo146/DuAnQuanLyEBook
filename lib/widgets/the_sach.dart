import 'package:flutter/material.dart';
import '../screens/doc_sach_screen.dart';
import '../models/sach.dart';

class TheSach extends StatelessWidget {

  final Sach sach;
  final VoidCallback onDelete;
  final VoidCallback onFavorite;

  const TheSach({
    super.key,
    required this.sach,
    required this.onDelete,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: ListTile(

        // ========================
        // MỞ MÀN HÌNH ĐỌC PDF
        // ========================

        onTap: () {

          Navigator.push(
            context,

            MaterialPageRoute(

              builder: (context) => DocSachScreen(

                duongDanFile: sach.duongDanFile,
                tieuDe: sach.tieuDe,
                bookId: sach.id!,

              ),
            ),
          );
        },

        // ========================
        // ICON PDF
        // ========================

        leading: const Icon(
          Icons.picture_as_pdf,
          color: Colors.red,
          size: 40,
        ),

        // ========================
        // TÊN SÁCH
        // ========================

        title: Text(
          sach.tieuDe,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        // ========================
        // THÔNG TIN SÁCH
        // ========================

        subtitle: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text("Tác giả: ${sach.tacGia}"),

            Text("Thể loại: ${sach.theLoai}"),

            Text(
              "Ngày thêm: ${sach.ngayThem.length >= 10
                ? sach.ngayThem.substring(0,10)
                 : sach.ngayThem}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

          ],
        ),

        // ========================
        // NÚT SAO + XÓA
        // ========================

        trailing: Row(

          mainAxisSize: MainAxisSize.min,

          children: [

            IconButton(

              icon: Icon(
                sach.yeuThich == 1
                    ? Icons.star
                    : Icons.star_border,

                color: sach.yeuThich == 1
                    ? Colors.amber
                    : Colors.grey,
              ),

              onPressed: onFavorite,
            ),

            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),

          ],
        ),
      ),
    );
  }
}