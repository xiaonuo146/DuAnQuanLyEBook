import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';

import '../services/tien_do_service.dart';
import '../services/ghi_am_service.dart';
import '../services/giongAI_service.dart';
import '../models/ghi_chu.dart';
class DocSachScreen extends StatefulWidget {

  final String duongDanFile;
  final String tieuDe;
  final int bookId;

  const DocSachScreen({
    super.key,
    required this.duongDanFile,
    required this.tieuDe,
    required this.bookId,
  });

  @override
  State<DocSachScreen> createState() => _DocSachScreenState();
}

class _DocSachScreenState extends State<DocSachScreen> {

  final PdfViewerController _pdfController = PdfViewerController();

  final TienDoService tienDoService = TienDoService();

  int tongTrang = 0;
  int trangHienTai = 0;
  int trangDaDoc = 0;
  GhiAmService speech = GhiAmService();
  String ghiChuText = "";
  giongAI tts = giongAI();


bool dangDoc = false;
bool dangGhiAm = false;
  @override
  void initState() {
    super.initState();
    taiTrangDaDoc();
  }

  Future<void> taiTrangDaDoc() async {

    trangDaDoc = await tienDoService.layTrang(widget.bookId);

    setState(() {
      trangHienTai = trangDaDoc;
    });

    if (trangDaDoc > 0) {
      Future.delayed(const Duration(milliseconds: 400), () {
        _pdfController.jumpToPage(trangDaDoc);
      });
    }
  }
  Future<String> layTextTrang(String path, int pageIndex) async {
  final bytes = File(path).readAsBytesSync();
  final document = PdfDocument(inputBytes: bytes);

  String text = PdfTextExtractor(document)
      .extractText(startPageIndex: pageIndex - 1, endPageIndex: pageIndex - 1);

  document.dispose();
  return text;
}
  @override
  Widget build(BuildContext context) {

    double tienTrinh = 0;

    if (tongTrang > 0) {
      tienTrinh = trangHienTai / tongTrang;
    }

    return Scaffold(

      appBar: AppBar(
        title: Text(widget.tieuDe),
        actions: [
          // 🔊 NÚT ĐỌC AI
          IconButton(
          icon: Icon(dangDoc ? Icons.stop : Icons.volume_up),
            onPressed: () async {

            if (dangDoc) {
             await tts.stop();
             setState(() => dangDoc = false);
              } else {

             await tts.init();

            String text = await layTextTrang(
            widget.duongDanFile,
              trangHienTai,
            );
              await tts.speak(text);

                 setState(() => dangDoc = true);
              }
            },
          ),
          IconButton(
  icon: Icon(dangGhiAm ? Icons.stop : Icons.mic),
  onPressed: () async {

    if (!dangGhiAm) {

      bool ok = await speech.init();

      if (ok) {
        speech.start((text) {
          setState(() {
            ghiChuText = text;
          });
        });

        setState(() => dangGhiAm = true);
      }

    } else {

      speech.stop();

      if (ghiChuText.isNotEmpty) {

        final ghiChu = GhiChu(
          bookId: widget.bookId,
          trang: trangHienTai,
          noiDung: ghiChuText, 
        );

        await tienDoService.themGhiChu(ghiChu);
      }

      setState(() => dangGhiAm = false);
    }
  },
),
        ]
      ),

      body: Column(
        children: [

          /// thanh tiến trình đọc
          if (tongTrang > 0)
            LinearProgressIndicator(
              value: tienTrinh,
              minHeight: 6,
            ),

          const SizedBox(height: 5),

          /// hiển thị %
          if (tongTrang > 0)
            Text(
              "Trang $trangHienTai / $tongTrang (${(tienTrinh * 100).toStringAsFixed(0)}%)",
              style: const TextStyle(fontSize: 14),
            ),

          const SizedBox(height: 5),
            if (ghiChuText.isNotEmpty)
                 Padding(
                  padding: const EdgeInsets.all(8),
                   child: Text("📝 Ghi chú: $ghiChuText"),
             ),
          Expanded(
            child: Stack(
              children: [

                /// PDF Viewer
                SfPdfViewer.file(

                  File(widget.duongDanFile),

                  controller: _pdfController,

                  /// khi load xong PDF
                  onDocumentLoaded: (details) {

                    setState(() {
                      tongTrang = details.document.pages.count;
                    });
                  },

                  /// khi đổi trang
                  onPageChanged: (details) {

                    trangHienTai = details.newPageNumber;

                    tienDoService.luuTrang(
                      widget.bookId,
                      trangHienTai,
                    );

                    setState(() {});
                  },
                ),

                /// hiển thị số trang
                Positioned(
                  bottom: 10,
                  right: 10,

                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black54,

                    child: Text(
                      "$trangHienTai/$tongTrang",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                /// hiển thị %
                Positioned(
                  bottom: 10,
                  left: 10,

                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black54,

                    child: Text(
                      tongTrang == 0
                          ? "0%"
                          : "${((trangHienTai / tongTrang) * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )

              ],
            ),
          ),

        ],
      ),
    );
  }
}