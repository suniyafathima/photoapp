import 'package:flutter/material.dart';
import 'package:photoapp/view/photo_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Picsum App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoListPage(),
    );
  }
}
