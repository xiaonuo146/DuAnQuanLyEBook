import 'package:flutter/material.dart';

import '../services/sach_service.dart';
import '../models/sach.dart';
import '../widgets/the_sach.dart';

class ManHinhYeuThich extends StatefulWidget {
  const ManHinhYeuThich({super.key});

  @override
  State<ManHinhYeuThich> createState() => _ManHinhYeuThichState();
}

class _ManHinhYeuThichState extends State<ManHinhYeuThich> {

  final SachService sachService = SachService();

  List<Sach> danhSachSach = [];

  @override
  void initState() {
    super.initState();
    taiSach();
  }

  Future<void> taiSach() async {

    danhSachSach = await sachService.laySachYeuThich();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Sách yêu thích"),
        centerTitle: true,
      ),

      body: danhSachSach.isEmpty
          ? const Center(
              child: Text("Chưa có sách yêu thích"),
            )
          : ListView.builder(

              itemCount: danhSachSach.length,

              itemBuilder: (context, index) {

                final sach = danhSachSach[index];

                return TheSach(
                  sach: sach,

                  onDelete: () async {

                    await sachService.xoaSach(sach.id!);

                    taiSach();
                  },

                  onFavorite: () async {

                    await sachService.capNhatYeuThich(
                      sach.id!,
                      0,
                    );

                    taiSach();
                  },
                );
              },
            ),
    );
  }
}