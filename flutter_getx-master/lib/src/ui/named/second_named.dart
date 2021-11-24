import 'package:flutter/material.dart';
import 'package:flutter_getx/src/ui/home.dart';
import 'package:get/get.dart';

class SecondNamed extends StatelessWidget {
  const SecondNamed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SecondNamed")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () {
              Get.back();
            }, child: Text("뒤로 이동")),
            TextButton(onPressed: () {
              Get.offAllNamed("/home");
            }, child: Text("홈으로 이동"))
          ],
        ),
      ),
    );
  }
}
