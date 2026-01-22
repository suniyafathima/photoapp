import 'package:flutter/material.dart';
import 'package:photoapp/controller/photoprovider.dart';
import 'package:photoapp/view/photo_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PhotoProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Picsum App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PhotoListPage(),
      ),
    );
  }
}
