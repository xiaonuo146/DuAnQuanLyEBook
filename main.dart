import 'package:flutter/material.dart';
import 'screens/main_navigation.dart';

void main() {
  runApp(const EReadApp());
}

class EReadApp extends StatefulWidget {
  const EReadApp({super.key});

  @override
  State<EReadApp> createState() => _EReadAppState();
}

class _EReadAppState extends State<EReadApp> {
  Color backgroundColor = Colors.white;

  // Hàm tự đổi màu chữ theo nền
  Brightness getBrightness(Color color) {
    return color.computeLuminance() > 0.5
        ? Brightness.light
        : Brightness.dark;
  }
Color lamNhatMau(Color color) {
  return Color.lerp(color, Colors.white, 0.7)!;
}
  @override
  Widget build(BuildContext context) {
    final brightness = getBrightness(backgroundColor);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ERead",

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: backgroundColor,
          brightness: brightness,
        ),
        scaffoldBackgroundColor: backgroundColor,
      ),

      home: MainNavigation(
       onChangeColor: (Color newColor) {
  setState(() {
    backgroundColor = lamNhatMau(newColor);
  });
},
      ),
    );
  }
}