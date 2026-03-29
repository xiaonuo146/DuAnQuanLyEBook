import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../models/sach.dart';
import '../services/sach_service.dart';

class DialogThemPDF {

  static Future<void> hienThi(
    BuildContext context,
    List<String> danhSachChuDe,
    SachService sachService,
    Function taiSach,
  ) async {

    TextEditingController tenSach = TextEditingController();
    TextEditingController tacGia = TextEditingController();

    String theLoai = "Khác";

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: const Text("Thêm sách PDF"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

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

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Hủy"),
            ),

            ElevatedButton(
              onPressed: () async {

                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                if (result != null) {

                  final file = result.files.single;

                  final sach = Sach(
                    tieuDe: tenSach.text,
                    tacGia: tacGia.text,
                    theLoai: theLoai,
                    duongDanFile: file.path!,
                    ngayThem: DateTime.now().toString(),
                    yeuThich: 0,
                  );

                  await sachService.themSach(sach);

                  Navigator.pop(context);

                  taiSach();
                }
              },
              child: const Text("Chọn PDF"),
            ),
          ],
        );
      },
    );
  }
}