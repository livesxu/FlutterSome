import 'package:flutter/material.dart';
import 'package:test_app/Home/HomeViewController.dart';
import 'package:test_app/Home/HomeSubViewController.dart';
import 'package:test_app/Mine/MineViewController.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP_Name',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
//      home: HomeViewController(),
      initialRoute: "/",//初始页面
      routes: {
        "/":(context) => MineViewController(),//路由映射
        "/routerNameToNext":(context) => HomeSubHomeViewController(title: "RouterNameToNext",)
      },
    );
  }
}
