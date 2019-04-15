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
      body: ExpansionPanelExample(),
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


//bottomSheet -
class BottomSheetExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomSheetExampleState();
  }
}

class BottomSheetExampleState extends State<BottomSheetExample> {

  final bodyKey = GlobalKey<ScaffoldState>();

  String isChoose = "AlertDialog";

  //1.弹出底部 - 无遮挡，可继续操作页面 -使用方式bodyKey.currentState.showBottomSheet
  _bottomSheetAction (){

    bodyKey.currentState.showBottomSheet((BuildContext context){

      return Container(height: 100,color: Colors.blue,child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Text("123")],),);
    });
  }
  
  //2.弹出底部 - 无遮挡，可继续操作页面 - showBottomSheet
  _bottom2SheetAction (){
    
    showBottomSheet(context: context, builder: (BuildContext context){

      return Container(height: 100,color: Colors.blue,child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[Text("456")],),);
    });
  }

  //3.弹出底部 - 有遮挡
  _bottomModelSheetAction () async {

    final option = await showModalBottomSheet(context: context, builder: (BuildContext context){

      return Container(color: Colors.blue,child: Column(children: <Widget>[
        ListTile(onTap: (){Navigator.of(context).pop("a");},title: Text("optionA"),),
        ListTile(onTap: (){Navigator.of(context).pop("b");},title: Text("optionB"),),
        ListTile(onTap: (){Navigator.of(context).pop("c");},title: Text("optionC"),),
        ListTile(onTap: (){Navigator.of(context).pop("d");},title: Text("optionD"),),],),);
    });

    print(option);
  }
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(key: bodyKey, body: RaisedButton.icon(onPressed: _bottomModelSheetAction, icon: Icon(Icons.local_grocery_store), label: Text(isChoose)),);
  }
}


//snackBar -
class SnackBarExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SnackBarExampleState();
  }
}

class SnackBarExampleState extends State<SnackBarExample> {

  final bodyKey = GlobalKey<ScaffoldState>();

  String isChoose = "AlertDialog";

  //1.弹出底部操作提示栏 -使用方式bodyKey.currentState.showSnackBar
  _snackBarAction (){

    bodyKey.currentState.showSnackBar(

      SnackBar(content: Text("123"),action: SnackBarAction(label: "OK", onPressed: (){}),)
    );
  }

  //2.弹出底部操作提示栏 -使用方式Scaffold.of(context).showSnackBar
  _snackBar2Action (){

    Scaffold.of(context).showSnackBar(

        SnackBar(content: Text("456"),action: SnackBarAction(label: "OK", onPressed: (){}),)
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(key: bodyKey, body: RaisedButton.icon(onPressed: _snackBar2Action, icon: Icon(Icons.local_grocery_store), label: Text(isChoose)),);
  }
}



//snackBar -
class ExpansionPanelExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExpansionPanelExampleState();
  }
}

class ExpansionPanelExampleState extends State<ExpansionPanelExample> {

  List<ExpansionPanelItem> itemDatas;

  @override
  void initState() {
    super.initState();

    itemDatas = [

      ExpansionPanelItem(headerText: "A",body:Container(child: Text("1"),),isExpanded: false),
      ExpansionPanelItem(headerText: "B",body:Container(child: Text("2"),),isExpanded: false),
      ExpansionPanelItem(headerText: "C",body:Container(child: Text("3"),),isExpanded: false),
      ExpansionPanelItem(headerText: "D",body:Container(child: Text("4"),),isExpanded: false),
      ExpansionPanelItem(headerText: "E",body:Container(child: Text("5"),),isExpanded: false),

    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
    ExpansionPanelList(children: itemDatas.map((ExpansionPanelItem item){

      return ExpansionPanel(headerBuilder: (BuildContext context,bool isExpand){return Container(child: Text(item.headerText),);}, body: item.body,isExpanded: item.isExpanded);

    }).toList(),expansionCallback: (int index,bool isExpanded){

      setState(() {

        itemDatas[index].isExpanded = !isExpanded;
      });
    },)],
    );
  }
}

class ExpansionPanelItem  {

  final String headerText;
  final Widget body;

  bool isExpanded;

  ExpansionPanelItem({
    this.headerText,
    this.body,
    this.isExpanded,
  });

}