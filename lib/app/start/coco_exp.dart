import '/data/abstraction/i_explore_icon_manager.dart';
import '/data/abstraction/i_image_manager.dart';
import '/data/local/concrency/local_explore_icon_manager.dart';
import '/data/remote/concrency/coco_image_network_manager.dart';
import '/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CocoExp extends StatefulWidget {
  const CocoExp({super.key});

  @override
  State<CocoExp> createState() => _CocoExpState();
}

class _CocoExpState extends State<CocoExp> {
  @override
  void initState() {
    super.initState();
    //add dependencies to Get di container based on parent class
    Get.put<IExploreIconManager>(LocalExploreIconManager());
    Get.put<IImageManager>(CocoImageNetworkManager());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Coco explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomeScreen.route: (_) => const HomeScreen(),
      },
      initialRoute: HomeScreen.route,
    );
  }
}
