import 'package:flutter/material.dart';
import 'package:flutter_getx/src/ui/dependencies/dependency_manage_page.dart';
import 'package:flutter_getx/src/ui/normal/first.dart';
import 'package:flutter_getx/src/ui/reactive_state/reactive_state_management.dart';
import 'package:flutter_getx/src/ui/simple_state/simple_state_management.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("라우트 관리 홈"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: () {
              Get.to(First());
            }, child: Text("일반적인 라우트")),
            TextButton(onPressed: () {
              Get.toNamed("/first");
            }, child: Text("Named 라우트")),
            TextButton(onPressed: () {
              Get.toNamed("/next", arguments: "Mino");
            }, child: Text("Argument 전달")),
            TextButton(onPressed: () {
              Get.toNamed("/user/28357?name=Mino&age=26");
            }, child: Text("동적 url 전달")),
            TextButton(onPressed: () {
              Get.to(SimpleState());
            }, child: Text("Simple 상태관리")),
            TextButton(onPressed: () {
              Get.to(ReactiveState());
            }, child: Text("Reactive 상태관리")),
            TextButton(onPressed: () {
              Get.to(DependencyManage());
            }, child: Text("의존성 관리")),
            TextButton(onPressed: () {
              Get.toNamed("/binding");
            }, child: Text("바인딩")),
          ],
        ),
      ),
    );
  }
}
