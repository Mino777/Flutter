import 'package:get/get.dart';

class CountControllerReactive extends GetxController {

  static CountControllerReactive get to => Get.find();

  RxInt count = 0.obs;

  void increase() {
    count++;
  }

  void put(int value) {
    count(value);
  }

  @override
  void onInit() {

    ever(count, (_) => print("매번 호출"));
    once(count, (_) => print("한번만 호출"));
    debounce(count, (_) => print("마지막 변경에 한번만 호출"), time: Duration(seconds: 1));
    interval(count, (_) => print("변경되고 있는 동안 1초마다 호출"), time: Duration(seconds: 1));

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
