import 'package:flutter/material.dart';

import '../services/tai_file_service.dart';
import '../services/sach_service.dart';
import '../models/sach.dart';

class DialogTaiURL {

  static Future<void> hienThi(
    BuildContext context,
    List<String> danhSachChuDe,
    SachService sachService,
    Function taiSach,
  ) async {

    TextEditingController urlController = TextEditingController();
    TextEditingController tenSach = TextEditingController();
    TextEditingController tacGia = TextEditingController();

    String theLoai = "Khác";

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: const Text("Tải sách từ URL"),
          content: SingleChildScrollView(
            child: Column(
              children: [

                TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: "Link PDF",
                  ),
                ),

                TextField(
                  controller: tenSach,
                  decoration: const InputDecoration(
                    labelText: "Tên sách",
                  ),
                ),

                TextField(
                  controller: tacGia,
                  decoration: const InputDecoration(
                    labelText: "Tác giả",
                  ),
                ),

                DropdownButtonFormField(
                  value: theLoai,
                  items: danhSachChuDe
                      .where((e) => e != "Tất cả")
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    theLoai = value!;
                  },
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Hủy"),
            ),

            ElevatedButton(
              onPressed: () async {

                String url = urlController.text;

                Navigator.pop(context);

                String tenFile =
                    "sach_${DateTime.now().millisecondsSinceEpoch}.pdf";

                String? duongDan =
                    await TaiFileService.taiPDF(url, tenFile);

                if (duongDan != null) {

                  final sach = Sach(
                    tieuDe: tenSach.text,
                    tacGia: tacGia.text,
                    theLoai: theLoai,
                    duongDanFile: duongDan,
                    ngayThem: DateTime.now().toString(),
                    yeuThich: 0,
                  );

                  await sachService.themSach(sach);

                  taiSach();
                }
              },
              child: const Text("Tải"),
            ),
          ],
        );
      },
    );
  }
}