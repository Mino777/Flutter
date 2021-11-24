import 'package:get/get.dart';

class CountController extends GetxController {
  static CountController get to => Get.find();

  late int firstcount = 0;
  late int secondCount = 0;

  void increase(String id) {
    switch (id) {
      case "first":
        firstcount++;
        break;
      case "second":
        secondCount++;
        break;
    }
    update([id]);
  }
}