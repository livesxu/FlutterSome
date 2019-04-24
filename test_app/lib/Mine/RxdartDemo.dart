import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class RxdartDemo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RxdartDemoState();
  }
}

class RxdartDemoState extends State<RxdartDemo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("RxdartDemo"),),
      body: RxdartDemoExample(),
    );
  }
}

class RxdartDemoExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RxdartDemoExampleState();
  }
}

class RxdartDemoExampleState extends State<RxdartDemoExample> {

  ReplaySubject<String> _subject;

  String _data = "...";

  @override
  void dispose() {

    _subject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

//    Observable<String> _observable =
//    Observable(Stream.fromIterable(["hello","您好"]));//根据迭代内容
//    Observable.fromFuture(Future.value("hello ~"));//根据future内容
//    Observable.fromIterable(["hello","您好"]);//根据迭代内容
//    Observable.just("hello ~");//根据内容
//    Observable.periodic(Duration(seconds: 3),(int x) => x.toString());//周期执行

//    _observable.listen(print);
//    _subject = PublishSubject<String>();//遵循监听，先听，再发才可收到
//    _subject = BehaviorSubject<String>();//把最后一次添加的数据监听返回
    _subject = ReplaySubject<String>(maxSize: 2);//把添加的所有内容都监听返回,maxSize可设置返回最大接受数据个数，类 栈 从后往前

    _subject.add("hello ~");
    _subject.add("hola ~");
    _subject.add("hi ~");

    _subject.listen((data) => print("listen 1:$data"));

    _subject.listen((data) => print("listen 2:${data.toUpperCase()}"));




  }

  Future<String> delayData () async {

    await Future.delayed(Duration(seconds: 3));

//    throw "something happened";

    return "Hello World ~";
  }

  void addData () async {

    String data = await delayData();

  }

  void onDataAction (String string){

    setState(() {
      _data = string;
    });
    print(string);
  }

  void onDataTwoAction (String string){


    print("twoAction:$string");
  }

  void onErrorAction (error) {

    print("An error");
  }

  void onDoneAction () {

    print("done action");
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Column(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              RaisedButton(onPressed: (){addData();}, child: Text("add")),//添加
              RaisedButton(onPressed: (){}, child: Text("pause")),//暂停
              RaisedButton(onPressed: (){}, child: Text("resume")),//恢复
              RaisedButton(onPressed: (){}, child: Text("cancel")),//取消
            ],),
          ],
        )
    );
  }
}