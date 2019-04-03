import 'package:flutter/material.dart';

class TextFieldDemo extends StatefulWidget {

  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextFieldFirstState();
  }
}

class TextFieldFirstState extends State<TextFieldDemo> {

  final formKey = GlobalKey<FormState>();

  String name,password;

  String _validatorName (String value) {

    if (value.isEmpty) {

      return "Username is required.";
    }
    return null;
  }

  void _submitAction () {

    formKey.currentState.save();
    formKey.currentState.validate();

    print("user:$name,password:$password");

    //底部提示
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("Snack"))
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 8,right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Username",
                helperText: "提示信息",//提示信息示例
              ),
              validator: _validatorName,
              autovalidate: true,
              onSaved: (String value){

                name = value;
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",

              ),
              onSaved: (String value){

                password = value;
              },
            ),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,//设置宽度与外部一样长
              child:RaisedButton(
                elevation: 0.0,
                color: Colors.red,//按钮背景颜色(必须设置onPressed值，否则展示disabledColor)
                disabledColor:Colors.green,
                onPressed: _submitAction,
                child: Text("Register",style: TextStyle(color: Colors.white),),
              ),
            ),

          ],
        ),
      ),
    );
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