import 'package:flutter/material.dart';

class WidgetLocChuDe extends StatelessWidget {

  final List<String> danhSachChuDe;

  final Set<String> chuDeDangChon;

  final Function(String) onChon;

  const WidgetLocChuDe({
    super.key,
    required this.danhSachChuDe,
    required this.chuDeDangChon,
    required this.onChon,
  });

  @override
  Widget build(BuildContext context) {

    return Wrap(

      spacing: 8,

      children: danhSachChuDe.map((chuDe) {

        bool dangChon = chuDeDangChon.contains(chuDe);

        return ChoiceChip(

          label: Text(chuDe),

          selected: dangChon,

          onSelected: (value) {
            onChon(chuDe);
          },
        );

      }).toList(),
    );
  }
}