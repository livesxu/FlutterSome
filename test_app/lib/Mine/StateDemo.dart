import 'package:flutter/material.dart';

class StateDemo extends StatefulWidget {

  @override
  StateDemoState createState() => StateDemoState();
}

class StateDemoState extends State<StateDemo> {

  int _count = 0;

  void _pressedAction (){

    setState(() {
      _count ++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InheritedProvider(
      count: _count,
      callback: _pressedAction,
      child: Scaffold(
        appBar: AppBar(title: Text("StateDemo"),),
        body: Center(
          child: CustomChipItemWrapper(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _pressedAction,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

/// ```dart - 系统示例
/// class FrogColor extends InheritedWidget {
///   const FrogColor({
///     Key key,
///     @required this.color,
///     @required Widget child,
///   }) : assert(color != null),
///        assert(child != null),
///        super(key: key, child: child);
///
///   final Color color;
///
///   static FrogColor of(BuildContext context) {
///     return context.inheritFromWidgetOfExactType(FrogColor) as FrogColor;
///   }
///
///   @override
///   bool updateShouldNotify(FrogColor old) => color != old.color;
/// }

class InheritedProvider extends InheritedWidget {

  final int count;
  final VoidCallback callback;
  final Widget child;

  InheritedProvider({

    this.count,
    this.callback,
    this.child,
  }) : super(child:child);

  static InheritedProvider of(BuildContext context) {
    
    return context.inheritFromWidgetOfExactType(InheritedProvider);
  }
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }
}

class CustomChipItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ActionChip(
      label: Text("${InheritedProvider.of(context).count}"),
      onPressed: InheritedProvider.of(context).callback,
    );
  }
}

class CustomChipItemWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomChipItem();
  }
}

