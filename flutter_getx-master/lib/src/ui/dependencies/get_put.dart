import 'package:flutter/material.dart';
import 'package:flutter_getx/src/controller/dependency_controller.dart';
import 'package:get/get.dart';

class GetPut extends StatelessWidget {
  const GetPut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: TextButton(
          onPressed: () {
            Get.find<DependencyController>().increase;
          },
          child: Text("TEST"),
        )
    );
  }
}
