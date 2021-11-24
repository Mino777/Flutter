import 'package:flutter/material.dart';
import 'package:flutter_getx/src/ui/normal/second.dart';
import 'package:get/get.dart';

class FirstNamed extends StatelessWidget {
  const FirstNamed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FirstNamed")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () {
              Get.toNamed("/second");
            }, child: Text("다음페이지 이동"))
          ],
        ),
      ),
    );
  }
}
