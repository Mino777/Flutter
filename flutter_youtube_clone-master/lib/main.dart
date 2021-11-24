import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube_clone/src/app.dart';
import 'package:flutter_youtube_clone/src/binding/init_binding.dart';
import 'package:flutter_youtube_clone/src/components/youtube_detail.dart';
import 'package:flutter_youtube_clone/src/controller/youtube_search_controller.dart';
import 'package:flutter_youtube_clone/src/pages/search.dart';
import 'package:get/get.dart';

import 'src/controller/youtube_detail_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Youtube CLone App",
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialBinding: InitBinding(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => App()),
        GetPage(
          name: "/detail/:videoId",
          page: () => YoutubeDetail(),
          binding: BindingsBuilder(
            () => Get.lazyPut<YoutubeDetailController>(
              () => YoutubeDetailController(),
            ),
          ),
        ),
        GetPage(
          name: "/search",
          page: () => YoutubeSearch(),
          binding: BindingsBuilder(
                () => Get.lazyPut<YoutubeSearchController>(
                  () => YoutubeSearchController(),
            ),
          ),
        ),
      ],
    );
  }
}
