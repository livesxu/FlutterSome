import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
    return ScopedModel(
      model: ScopedModelExample(),
      child: Scaffold(
        appBar: AppBar(title: Text("StateDemo"),),
        body: Center(
          child: CustomChipItemWrapper(),
        ),
        floatingActionButton: ScopedModelDescendant(rebuildOnChange: false,builder: (context,_,ScopedModelExample model){
          return FloatingActionButton(
            onPressed: model.increaseCount,
            child: Icon(Icons.add),
          );
        })
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
    return ScopedModelDescendant(
        builder: (context,_,ScopedModelExample model) => ActionChip(
          label: Text("${model.count}"),
          onPressed: model.increaseCount,
        )
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

class ScopedModelExample extends Model {

  int _count = 0;
  int get count => _count;

  void increaseCount(){

    _count += 1;
    notifyListeners();
  }

}

