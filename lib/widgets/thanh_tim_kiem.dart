import 'package:flutter/material.dart';

class ThanhTimKiem extends StatelessWidget {

  final Function(String) onChanged;

  const ThanhTimKiem({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10),

      child: TextField(

        decoration: InputDecoration(

          hintText: "Tìm theo tên sách, tác giả, thể loại",

          prefixIcon: const Icon(Icons.search),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        onChanged: onChanged,
      ),
    );
  }
}