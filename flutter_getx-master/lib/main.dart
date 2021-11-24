import 'package:flutter/material.dart';
import 'package:flutter_getx/src/controller/count_controller.dart';
import 'package:flutter_getx/src/ui/argument/user.dart';
import 'package:flutter_getx/src/ui/binding/binding.dart';
import 'package:flutter_getx/src/ui/binding/binding_to_binding.dart';
import 'package:flutter_getx/src/ui/home.dart';
import 'package:flutter_getx/src/ui/named/first_named.dart';
import 'package:flutter_getx/src/ui/named/second_named.dart';
import 'package:flutter_getx/src/ui/argument/next.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      getPages: [
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/first", page: () => FirstNamed()),
        GetPage(name: "/second", page: () => SecondNamed()),
        GetPage(name: "/next", page: () => Next()),
        GetPage(name: "/user/:uid", page: () => User()),
        GetPage(
            name: "/binding",
            page: () => Binding(),
            binding: BindingToBinding())
      ],
    );
  }
}
