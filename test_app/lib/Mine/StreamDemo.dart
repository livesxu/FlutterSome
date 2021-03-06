import 'package:flutter/material.dart';
import 'dart:async';

class StreamDemo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StreamDemoState();
  }
}

class StreamDemoState extends State<StreamDemo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("StreamDemo"),),
      body: StreamDemoExample(),
    );
  }
}

class StreamDemoExample extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StreamDemoExampleState();
  }
}

class StreamDemoExampleState extends State<StreamDemoExample> {

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
    
//    Stream<String> _streamDemo = Stream.fromFuture(delayData());

    _streamController = StreamController.broadcast();

    _sink = _streamController.sink;

    _streamSubscripthon = _streamController.stream.listen(onDataAction,onError: onErrorAction,onDone: onDoneAction,cancelOnError: false,);

    _streamController.stream.listen(onDataTwoAction,onError: onErrorAction,onDone: onDoneAction,cancelOnError: false,);
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