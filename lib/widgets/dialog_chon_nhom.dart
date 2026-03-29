import 'package:flutter/material.dart';
import '../services/nhom_service.dart';

class DialogChonNhom {

  static Future<void> hienThi(
    BuildContext context,
    int bookId,
    NhomService nhomService,
  ) async {

    final nhomList = await nhomService.layDanhSachNhom();

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: const Text("Thêm vào nhóm"),

          content: SizedBox(
            width: double.maxFinite,

            child: ListView(
              shrinkWrap: true,

              children: [

                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text("Tạo nhóm mới"),

                  onTap: () {

                    TextEditingController controller =
                        TextEditingController();

                    showDialog(
                      context: context,
                      builder: (context) {

                        return AlertDialog(

                          title: const Text("Tên nhóm"),

                          content: TextField(
                            controller: controller,
                          ),

                          actions: [

                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Hủy"),
                            ),

                            TextButton(
                              onPressed: () async {

                                await nhomService.taoNhom(
                                  controller.text,
                                );

                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("Tạo"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                ...nhomList.map((nhom) {

                  return ListTile(
                    title: Text(nhom['tenNhom']),

                    onTap: () async {

                      await nhomService.themSachVaoNhom(
                        bookId,
                        nhom['id'],
                      );

                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}