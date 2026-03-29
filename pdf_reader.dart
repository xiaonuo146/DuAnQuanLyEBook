import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfReader extends StatelessWidget {

  final String path;

  const PdfReader({super.key, required this.path});

  @override
  Widget build(BuildContext context) {

    return SfPdfViewer.file(
      File(path),
    );
  }
}