import 'package:flutter/material.dart';
import 'package:flutter_getx/src/ui/home.dart';
import 'package:get/get.dart';

class Next extends StatelessWidget {
  const Next({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${Get.arguments}"),
            SizedBox(
              height: 50,
            ),
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
