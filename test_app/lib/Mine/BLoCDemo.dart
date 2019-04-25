import 'package:flutter/material.dart';
import 'dart:async';

class BLocDemo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BLocDemoState();
  }
}

class BLocDemoState extends State<BLocDemo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InheritedBloc(
      bloc: BlocExample(),
      child:  Scaffold(
        appBar: AppBar(title: Text("BLocDemo"),),
        body: BLocDemoExample(),
      ),
    );
  }
}

class BLocDemoExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BLocDemoExampleState();
  }
}
//1.共享一个bloc,事件通过stream传递（传入）
//2.bloc里面有一个信息更新的stream，将这个stream提供给StreamBuilder
//3.StreamBuilder更新页面
class BLocDemoExampleState extends State<BLocDemoExample> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        initialData: 0,
        stream: InheritedBloc.of(context).bloc.stream,
        builder: (BuildContext context,snapshot) {

          return Scaffold(
            body: ActionChip(label: Text("${snapshot.data}"), onPressed: (){

              InheritedBloc.of(context).bloc.conter.add(1);
            }),
            floatingActionButton: FloatingActionButton(onPressed: (){

              InheritedBloc.of(context).bloc.conter.add(1);
            },child: Icon(Icons.add),),
          );
        }
    );
  }
}

class InheritedBloc extends InheritedWidget {

  final Widget child;
  final BlocExample bloc;

  InheritedBloc({
    this.child,
    this.bloc,
  }):super(child:child);

   static InheritedBloc of(BuildContext context) {
     return context.inheritFromWidgetOfExactType(InheritedBloc) as InheritedBloc;
   }

   @override
   bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }
}

class BlocExample{

  int _count = 0;

  final _counterActionStreamController = StreamController<int>();

  StreamSink<int> get conter => _counterActionStreamController.sink;

  final _counterController = StreamController<int>();

  Stream<int> get stream => _counterController.stream;

  BlocExample () {

    _counterActionStreamController.stream.listen(onData);

  }

  void onData (int data) {

    print(data.toString());

    _count += data;

    _counterController.add(_count);
  }

  void disponse() {

    _counterActionStreamController.close();
    _counterController.close();
  }

  void logAction() {

    print("print bloc");
  }
}