import 'package:flutter/material.dart';
import './consts.dart';
import 'dart:async';

class ErrorHandle {

  static systemError () {

    FlutterError.onError = (FlutterErrorDetails dedails) {

      if (Environment_debug) {

        FlutterError.dumpErrorToConsole(dedails);
      } else {

        ReportHandle.handle('Error_system', 0, dedails.exceptionAsString() + '\n' + dedails.stack.toString());
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

      ReportHandle.handle('Error_sync', 0, e.toString() + '\n' + stack.toString());
      catchThen();
    }
  }

//  异步异常
  static asyncError (VoidCallback doAction){

    runZoned(
      doAction,
      zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          print(line); //手机日志
        },
      ),
      onError: (Object obj, StackTrace stack) {

        ReportHandle.handle('Error_async', 0, obj.toString() + '\n' + stack.toString());
      },
    );
  }

}

class ReportHandle {

  static handle (String reportName,int reportLevel, String report){

    if (Environment_debug) {

      print(Version + reportName + reportLevel.toString() + '\n' + report);
    } else {
      //上报接口 todo

    }
  }
}