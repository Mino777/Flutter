import 'package:flutter/material.dart';
import 'package:flutter_getx/src/ui/home.dart';
import 'package:get/get.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${Get.parameters['uid']}"),
            Text("${Get.parameters['name']}님 안녕하세요."),
            Text("${Get.parameters['age']}"),
            SizedBox(
              height: 50,
            ),
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
