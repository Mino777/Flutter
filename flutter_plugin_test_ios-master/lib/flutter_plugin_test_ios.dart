
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginTestIos {
  static const MethodChannel _channel = MethodChannel('test');
  static const EventChannel networkChannel = EventChannel("networkingCheck");
  static const EventChannel recordChannel = EventChannel("record");

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
