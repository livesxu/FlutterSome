package com.example.flutter_plugin_test;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterPluginTestPlugin */
public class FlutterPluginTestPlugin implements MethodCallHandler {

  static Registrar registrarLink;
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_plugin_name_match");
    channel.setMethodCallHandler(new FlutterPluginTestPlugin());

    registrarLink = registrar;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("showMsg")) {

      String msg = (String) call.arguments;
      result.success(msg +"ppppp");
    } else {
      result.notImplemented();
    }
  }
}
