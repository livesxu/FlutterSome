package com.example.rss_readneed;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.widget.Toast;

import com.tencent.bugly.CrashModule;
import com.tencent.bugly.crashreport.CrashReport;

import java.util.Timer;

import androidx.annotation.NonNull;
import io.flutter.app.FlutterPluginRegistry;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements EventChannel.StreamHandler,MethodChannel.MethodCallHandler  {

    MethodChannel methodChannel;

    EventChannel.EventSink eventSink;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        CrashReport.initCrashReport(getApplicationContext(), "5a8ec93f75", false);

        methodChannel = new MethodChannel(flutterEngine.getDartExecutor(),"channel");
        methodChannel.setMethodCallHandler(this);

//        EventChannel eventChannel = new EventChannel(flutterEngine.getDartExecutor(),"event_1");
//        eventChannel.setStreamHandler(this);
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {

        if (call.method.equals("_bug_")) {//报错

            postFlutterExcetion(call.argument("name"), call.argument("obj"), call.argument("stack"));
            result.success(true);
        }
    }

    static void postFlutterExcetion(String excpetionType, String excpetionMessage, String stack) {
        if (!CrashModule.getInstance().hasInitialized()) return;
        CrashReport.postException(4, excpetionType, excpetionMessage, stack, null);
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {

        this.eventSink = events;

    }

    @Override
    public void onCancel(Object arguments) {

        Log.v("zzz","onCancel" + arguments.toString());
    }
}
