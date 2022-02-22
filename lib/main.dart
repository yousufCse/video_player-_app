import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_app/features/home/pages/home_page.dart';
import 'package:video_player_app/features/video_info/pages/video_info_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: VideoInfoPage(),
    );
  }
}
