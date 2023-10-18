import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    title: 'Namer App',
    theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
    ),
    home: const MyHomePage(),
    );
  }
}

