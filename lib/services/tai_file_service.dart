import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class TaiFileService {

  static Future<String?> taiPDF(String url, String tenFile) async {

    try {

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {

        final thuMuc = await getApplicationDocumentsDirectory();

        final duongDan = "${thuMuc.path}/$tenFile";

        final file = File(duongDan);

        await file.writeAsBytes(response.bodyBytes);

        return duongDan;

      } else {

        return null;

      }

    } catch (e) {

      return null;

    }

  }
}