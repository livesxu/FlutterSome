import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginTest {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_name_match');

  static Future<String> getShowMsg(String msg) async {

    final String newString = await _channel.invokeMethod("showMsg",msg);

    return newString;
  }
}
