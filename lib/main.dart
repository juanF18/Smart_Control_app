import 'package:flutter/material.dart';
import 'package:smart_control_hub_app/home/screen/home_smart_controle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00cdced2)),
        useMaterial3: true,
      ),
      home: const SmartHomeControl(),
    );
  }
}
