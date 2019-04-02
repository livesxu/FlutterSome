import 'package:flutter/material.dart';

class TextFieldDemo extends StatefulWidget {

  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextFieldDemoState();
  }
}

class TextFieldDemoState extends State<TextFieldDemo> {

  final TextEditingController editVc = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    editVc.dispose();//销毁
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    editVc.text = "Hi";//初始赋值
    //监听
    editVc.addListener(
        (){
        print(editVc.text);
       }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(16),
      child:TextField(
//        obscureText: true,//密码*隐藏
        decoration: InputDecoration(
          icon: Icon(Icons.access_alarm),
          labelText: "闹钟",//标题
          hintText: "请输入闹钟时间",//提示
          hintStyle: TextStyle(color: Colors.green,fontSize: 12),
          filled: true,//是否填充背景
          fillColor: Colors.red,//填充背景颜色
          border: OutlineInputBorder(),//全边框样式
//          border: InputBorder.none,//去除下边框
        ),
        onChanged: (String text){
          print(text);
        },
        onSubmitted: (String text){

          print("submit -> $text");
        },
        keyboardType: TextInputType.url,//键盘样式
        controller: editVc,
      ),);
  }
}