import 'package:flutter/material.dart';
import 'package:flutter_getx/src/ui/home.dart';
import 'package:get/get.dart';

class Second extends StatelessWidget {
  const Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () {
              Get.back();
            }, child: Text("뒤로 이동")),
            TextButton(onPressed: () {
              Get.offAll(Home());
            }, child: Text("홈으로 이동"))
          ],
        ),
      ),
    );
  }
}
