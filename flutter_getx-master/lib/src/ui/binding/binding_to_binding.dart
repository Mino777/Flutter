import 'package:flutter_getx/src/controller/count_controller.dart';
import 'package:flutter_getx/src/controller/count_reactive_controller.dart';
import 'package:get/get.dart';

class BindingToBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CountControllerReactive());
  }
}