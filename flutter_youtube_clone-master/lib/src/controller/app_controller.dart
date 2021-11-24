import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_youtube_clone/src/components/youtube_bottomsheet.dart';
import 'package:get/get.dart';

enum RouteName { Home, Explore, Add, Subscribe, Library }

class AppController extends GetxService {
  static AppController get to => Get.find();
  RxInt currentIndex = 0.obs;

  void changePageIndex(int index) {
    if (RouteName.values[index] == RouteName.Add) {
      _showBottomSheet();
    } else {
      currentIndex(index);
    }
  }

  void _showBottomSheet() {
    Get.bottomSheet(YoutubeBottomSheet());
  }
}
