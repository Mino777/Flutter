import 'package:flutter/material.dart';
import 'package:flutter_getx/src/controller/count_controller.dart';
import 'package:flutter_getx/src/controller/count_reactive_controller.dart';
import 'package:flutter_getx/src/ui/home.dart';
import 'package:get/get.dart';

class ReactiveState extends StatelessWidget {
  ReactiveState({Key? key}) : super(key: key);

  CountControllerReactive _countControllerReactive =
      Get.put(CountControllerReactive());

  Widget _increaseButton() {
    return TextButton(
      onPressed: () {
        _countControllerReactive.increase();
      },
      child: Text("+", style: TextStyle(fontSize: 30)),
    );
  }

  Widget _putButton(int value) {
    return TextButton(
      onPressed: () {
        _countControllerReactive.put(value);
      },
      child: Text("${value}로 변경", style: TextStyle(fontSize: 30)),
    );
  }


  @override
  Widget build(BuildContext context) {
    Get.put(CountController());

    return Scaffold(
      appBar: AppBar(title: Text("Reactive 상태관리")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  "${_countControllerReactive.count.value}",
                  style: TextStyle(fontSize: 50),
                )),
            SizedBox(
              height: 50,
            ),
            _increaseButton(),
            _putButton(2)
          ],
        ),
      ),
    );
  }
}
