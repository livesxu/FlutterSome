import 'package:flutter/material.dart';

class DialogDemo extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DialogDemoState();
  }
}

class DialogDemoState extends State<DialogDemo> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("DialogDemo"),),
      body: SimpleDialogDemoExample(),
    );
  }
}

//SimpleDialog -
class SimpleDialogDemoExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SimpleDialogDemoExampleState();
  }
}

class SimpleDialogDemoExampleState extends State<SimpleDialogDemoExample> {

  String tt;

  _dialogAction () async {

    final option = await showDialog(context: context,builder: (BuildContext context) {

      return SimpleDialog(
        title: Text("Dialog"),
        children: <Widget>[
          SizedBox(height: 20,),
          SimpleDialogOption(onPressed: (){Navigator.of(context).pop("a");},child: Text("optionA"),),
          SimpleDialogOption(onPressed: (){Navigator.of(context).pop("b");},child: Text("optionB"),),
          SimpleDialogOption(onPressed: (){Navigator.of(context).pop("c");},child: Text("optionC"),),
          SimpleDialogOption(onPressed: (){Navigator.of(context).pop("d");},child: Text("optionD"),),
        ],
      );
    });

    if (option == null) return;

    print(option);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton.icon(onPressed: _dialogAction, icon: Icon(Icons.local_grocery_store), label: Text("Dialog"));
  }
}

enum Action {

  cancel,
  ok
}

//AlertDialog -
class AlertDialogDemoExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AlertDialogDemoExampleState();
  }
}

class AlertDialogDemoExampleState extends State<AlertDialogDemoExample> {

  String isChoose = "AlertDialog";

  _dialogAction () async {
//barrierDismissible:false - 点按空白处不关闭对话框
    String chooseString  = await showDialog(context: context,barrierDismissible:false,builder: (BuildContext context) {

      return AlertDialog(
        title: Text("Alert Dialog"),
        content: Text("some infomation"),
        actions: <Widget>[
          FlatButton(onPressed: (){Navigator.pop(context,"Choose NO");}, child: Text("Cancel")),
          FlatButton(onPressed: (){Navigator.pop(context,"Choose YES");}, child: Text("OK")),
        ],
      );
    });

    if (chooseString == null) return;

    setState(() {
      isChoose = chooseString;
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RaisedButton.icon(onPressed: _dialogAction, icon: Icon(Icons.local_grocery_store), label: Text(isChoose));
  }
}