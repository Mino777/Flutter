import 'package:flutter/material.dart';
import 'package:flutter_getx/src/controller/dependency_controller.dart';
import 'package:flutter_getx/src/ui/dependencies/get_lazyPut.dart';
import 'package:flutter_getx/src/ui/dependencies/get_put.dart';
import 'package:get/get.dart';

class DependencyManage extends StatelessWidget {
  const DependencyManage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("의존성 주입"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Get.to(GetPut(), binding: BindingsBuilder(() {
                    Get.put(DependencyController()); // 메모리에 바로 올림
                  }));
                },
                child: Text("Get.put")),
            TextButton(
                onPressed: () {
                  Get.to(GetLazyPut(), binding: BindingsBuilder(() {
                    Get.lazyPut<DependencyController>(
                        // 컨트롤러에 접근을 하려고 할 때 메모리에 올림
                        () => DependencyController());
                  }));
                },
                child: Text("Get.lazyPut")),
            TextButton(
                onPressed: () {
                  Get.to(GetPut(), binding: BindingsBuilder(() {
                    Get.putAsync<DependencyController>(() async {
                      await Future.delayed(Duration(seconds: 5));
                      return DependencyController();
                    });
                  }));
                },
                child: Text("Get.putAsync")),
            TextButton(onPressed: () {
              Get.to(GetPut(), binding: BindingsBuilder(() { // lazyPut과 거의 동일하지만, lazyPut의 경우엔 처음만 이니셜라이즈 되지만 create의 경우엔 계속해서 이니셜라이즈됨.
                Get.create<DependencyController>(() => DependencyController());
              }));
            }, child: Text("Get.create")),
          ],
        ),
      ),
    );
  }
}
