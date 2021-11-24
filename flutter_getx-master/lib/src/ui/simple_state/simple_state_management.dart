import 'package:flutter/material.dart';
import 'package:flutter_getx/src/controller/count_controller.dart';
import 'package:flutter_getx/src/ui/home.dart';
import 'package:get/get.dart';

class SimpleState extends StatelessWidget {
  SimpleState({Key? key}) : super(key: key);

  CountController _countController = Get.put(CountController());

  Widget _button(String id) {
    return TextButton(
      onPressed: () {
        _countController.increase(id);
      },
      child: Text("+", style: TextStyle(fontSize: 30)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(CountController());

    return Scaffold(
      appBar: AppBar(title: Text("Simple 상태관리")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<CountController>(
              id: "first",
              builder: (controller) {
                return Text("${controller.firstcount}", style: TextStyle(fontSize: 50),);
              },
            ),
            GetBuilder<CountController>(
              id: "second",
              builder: (controller) {
                return Text("${controller.secondCount}", style: TextStyle(fontSize: 50),);
              },
            ),
            SizedBox(
              height: 50,
            ),
            _button("first"),
            _button("second")
          ],
        ),
      ),
    );
  }
}
