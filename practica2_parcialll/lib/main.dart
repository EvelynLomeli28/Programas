import 'package:flutter/material.dart';
import 'package:practica2_parcialll/widget/pagina1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practica 2',
      home: Pagina1(),
    );
  }
}


