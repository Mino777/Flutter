import 'package:flutter/material.dart';
import 'package:flutter_getx/src/controller/count_reactive_controller.dart';
import 'package:get/get.dart';

class Binding extends GetView<CountControllerReactive> {
  const Binding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
            Obx(() => Text(
              "${controller.count.toString()}",
              style: TextStyle(fontSize: 50),
            )),
          TextButton(
              onPressed: () {
                controller.increase();
              },
              child: Text("+"))
        ],
      ),
    );
  }
}
