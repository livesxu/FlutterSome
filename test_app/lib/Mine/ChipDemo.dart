import 'package:flutter/material.dart';

class ChipDemo extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChipDemoState();
  }
}

class ChipDemoState extends State<ChipDemo> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("ClipDemo"),),
      body: ChipDemoExample(),
    );;
  }
}

class ChipDemoExample extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChipDemoExampleState();
  }
}

class ChipModel {

  String title;
  String text;

  ChipModel({
    this.title,
    this.text,
  });
}

class ChipDemoExampleState extends State<ChipDemoExample> {

  List<ChipModel> chips;

  String actionSeleted = "Nothing";
  List<ChipModel> filters = [];

  String choiceOne = "Nothing";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    chips = [
      ChipModel(title: "快",text: "This"),
      ChipModel(title: "乐",text: "is"),
      ChipModel(title: "福",text: "a"),
      ChipModel(title: "开",text: "good"),
      ChipModel(title: "心",text: "life"),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
//              alignment: WrapAlignment.center,
//              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 10,//水平间距
//          runSpacing: 10,//竖直间距
              children: chips.map((ChipModel model){
                return Chip(
                  label: Text(model.text),
                  avatar: CircleAvatar(child: Text(model.title),),
                  onDeleted: (){
                    setState(() {
                      chips.remove(model);
                    });
                  },
//                  deleteIcon: Icon(Icons.delete),//删除按钮
//                  deleteIconColor: ,
//                  deleteButtonTooltipMessage: "长按删除按钮提示内容",
                );
              }).toList(),
            ),
            Divider(//可放在wrap内部
              indent: 0,//首端缩进
              height: 10,
            ),//分割线
            Container(
              width: double.infinity,
              child: Text("ActionChip:$actionSeleted"),
            ),
            Wrap(
              spacing: 10,//水平间距
              children: chips.map((ChipModel model){
                return ActionChip(
                  label: Text(model.text),
                  avatar: CircleAvatar(child: Text(model.title),),
                  onPressed: (){
                    setState(() {
                      actionSeleted = model.text;
                    });
                  },
                );
              }).toList(),
            ),
            Container(
              width: double.infinity,
              child: Text("FilterChip:${filters.toString()}"),
            ),
            Wrap(
              spacing: 10,//水平间距
              children: chips.map((ChipModel model){
                return FilterChip(
                  label: Text(model.text),
                  avatar: CircleAvatar(child: Text(model.title),),
                  selected: filters.contains(model),
                  selectedColor: Colors.red,
                  onSelected: (bool isSelected){
                    setState(() {

                      if (isSelected) {

                        filters.add(model);
                      } else {

                        filters.remove(model);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            Container(
              width: double.infinity,
              child: Text("ChoiceChip:$choiceOne"),
            ),
            Wrap(
              spacing: 10,//水平间距
              children: chips.map((ChipModel model){
                return ChoiceChip(
                  label: Text(model.text),
                  avatar: CircleAvatar(child: Text(model.title),),
                  selected: choiceOne == model.text,
                  selectedColor: Colors.red,
                  onSelected: (bool isSelected){
                    setState(() {

                      if (isSelected) {

                        choiceOne = model.text;
                      } else {

                        choiceOne = "Nothing";
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {

            chips = [
              ChipModel(title: "快",text: "This"),
              ChipModel(title: "乐",text: "is"),
              ChipModel(title: "福",text: "a"),
              ChipModel(title: "开",text: "good"),
              ChipModel(title: "心",text: "life"),
            ];

            actionSeleted = "Nothing";
            filters = [];
            choiceOne = "Nothing";

          });
        },
        child: Icon(Icons.refresh),),
    );
  }
}