import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './consts.dart';
import 'dart:async';

enum ReportLevel {
  ReportLevelError,//错误报告
  ReportLevelDebug,//debug报告
  ReportLevelNotes,//记录报告
}

class ErrorHandle {

  static MethodChannel methodChannel = MethodChannel("channel");

  static systemError () {

    FlutterError.onError = (FlutterErrorDetails dedails) {

      if (Environment_debug) {

        FlutterError.dumpErrorToConsole(dedails);
      } else {

        ReportHandle.handle('Error_system', ReportLevel.ReportLevelError, dedails.exceptionAsString(), dedails.stack.toString());
      }
    };
  }
//  同步异常
//  try {}
//  catch (e){}
//  final{}
  static syncError(VoidCallback doAction,VoidCallback catchThen) {

    try {
      doAction();
    }
    catch (e, stack){

      ReportHandle.handle('Error_sync', ReportLevel.ReportLevelError, e.toString(), stack.toString());
      catchThen();
    }
  }

//  异步异常
  static asyncError (VoidCallback doAction){

    runZoned(
      doAction,
      zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
//          print(line); //手机日志
        },
      ),
      onError: (Object obj, StackTrace stack) {

        ReportHandle.handle('Error_async', ReportLevel.ReportLevelError, obj.toString(), stack.toString());
      },
    );
  }

}

class ReportHandle {

  static handle (String reportName,ReportLevel reportLevel,String error, String stack){

    if (Environment_debug) {

      print(Version +  " " + reportName + "  " + reportLevel.toString() + '\n' + stack);
    } else {
      //上报接口 todo

      if (reportLevel == ReportLevel.ReportLevelError) {

        //错误回传native,上报bugly
        ErrorHandle.methodChannel.invokeMethod("_bug_",{"name":Version + " " + reportName,"obj":error,"stack":stack});
      }

    }
  }
}