import 'package:flutter/material.dart';

import 'thu_vien_screen.dart';
import 'yeu_thich_screen.dart';

class MainNavigation extends StatefulWidget {
  final Function(Color) onChangeColor; 

  const MainNavigation({
    super.key,
    required this.onChangeColor, 
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const ManHinhThuVien(),
    const ManHinhYeuThich(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: "Thư viện",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Yêu thích",
          ),
        ],
      ),

      // 👇 Nút đổi màu nền
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onChangeColor(
            Colors.primaries[
                DateTime.now().millisecondsSinceEpoch %
                    Colors.primaries.length],
          );
        },
        child: const Icon(Icons.color_lens),
      ),
    );
  }
}