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

  StreamSubscription _streamSubscripthon;
  StreamController<String> _streamController;
  StreamSink<String> _sink;

  String _data = "...";

  @override
  void dispose() {

    _streamController.close();//关闭
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
    

  }

  Future<String> delayData () async {

    await Future.delayed(Duration(seconds: 3));

//    throw "something happened";

    return "Hello World ~";
  }

  void addData () async {

    String data = await delayData();

//    _streamController.add(data);
    _sink.add(data);
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
            StreamBuilder(
                stream: _streamController.stream,
                initialData: "...",//初始数据
                builder: (BuildContext context,snapshot){
                  return Text("${snapshot.data}");
                }
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              RaisedButton(onPressed: (){addData();}, child: Text("add")),//添加
              RaisedButton(onPressed: (){_streamSubscripthon.pause();print("pause");}, child: Text("pause")),//暂停
              RaisedButton(onPressed: (){_streamSubscripthon.resume();print("resume");}, child: Text("resume")),//恢复
              RaisedButton(onPressed: (){_streamSubscripthon.cancel();print("cancel");}, child: Text("cancel")),//取消
            ],),
          ],
        )
    );
  }
}