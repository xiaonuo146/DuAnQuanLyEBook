import 'package:flutter/material.dart';

import '../services/sach_service.dart';
import '../services/nhom_service.dart';

import '../widgets/thanh_tim_kiem.dart';
import '../widgets/the_sach.dart';

import '../widgets/dialog_them_pdf.dart';
import '../widgets/dialog_tai_url.dart';
import '../widgets/dialog_chon_nhom.dart';
import '../widgets/loc_chu_de.dart';
import '../models/sach.dart';

class ManHinhThuVien extends StatefulWidget {
  const ManHinhThuVien({super.key});

  @override
  State<ManHinhThuVien> createState() => _ManHinhThuVienState();
}

class _ManHinhThuVienState extends State<ManHinhThuVien> {

  final SachService sachService = SachService();
  final NhomService nhomService = NhomService();

  List<Sach> danhSachSach = [];

  String tuKhoa = "";

  List<String> danhSachChuDe = [
    "Tất cả",
    "Tiểu thuyết","Truyện Teen","Truyện tranh", "Học tập", "Sáng tác" ,"Tài liệu" ,"Sách phát triển bản thân", 
    "Ngôn tình", "Đam mỹ", "Thanh xuân vườn trường","Xuyên không", "Trinh thám" , "Trọng sinh", "Tiên hiệp",
    "Khác"
  ];

  Set<String> chuDeDangChon = {};

  @override
  void initState() {
    super.initState();
    taiSach();
  }

  // =========================
  // TẢI DANH SÁCH SÁCH
  // =========================

  Future<void> taiSach() async {

    danhSachSach = await sachService.layDanhSachSach();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final ketQua = danhSachSach.where((s) {

      bool dungTimKiem =
          s.tieuDe.toLowerCase().contains(tuKhoa.toLowerCase()) ||
          s.tacGia.toLowerCase().contains(tuKhoa.toLowerCase()) ||
          s.theLoai.toLowerCase().contains(tuKhoa.toLowerCase());

      bool dungTheLoai = chuDeDangChon.isEmpty
          ? true
          : chuDeDangChon.contains(s.theLoai);

      return dungTimKiem && dungTheLoai;

    }).toList();

    return Scaffold(

      appBar: AppBar(
        title: const Text("Thư viện EBook"),
        centerTitle: true,

        actions: [

          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              DialogTaiURL.hienThi(
                context,
                danhSachChuDe,
                sachService,
                taiSach,
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DialogThemPDF.hienThi(
            context,
            danhSachChuDe,
            sachService,
            taiSach,
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [

            ThanhTimKiem(
              onChanged: (value) {
                setState(() {
                  tuKhoa = value;
                });
              },
            ),

            const SizedBox(height: 10),
    WidgetLocChuDe(
       danhSachChuDe: danhSachChuDe,
        chuDeDangChon: chuDeDangChon,
          onChon: (chuDe) {
          setState(() {
              if (chuDe == "Tất cả") {
                 chuDeDangChon.clear();
             } else {
              if (chuDeDangChon.contains(chuDe)) {
                 chuDeDangChon.remove(chuDe);
              } else {
                chuDeDangChon.add(chuDe);
             }
           }
          });
        },
        ),

        const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: ketQua.length,

                itemBuilder: (context, index) {

                  final sach = ketQua[index];

                  return TheSach(
                    sach: sach,

                    onDelete: () async {

                      await sachService.xoaSach(sach.id!);

                      taiSach();
                    },

                    onFavorite: () async {

                      await sachService.capNhatYeuThich(
                        sach.id!,
                        sach.yeuThich == 1 ? 0 : 1,
                      );

                      DialogChonNhom.hienThi(
                        context,
                        sach.id!,
                        nhomService,
                      );

                      taiSach();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}