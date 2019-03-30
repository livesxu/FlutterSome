import 'package:flutter/material.dart';
import 'package:test_app/Home/HomeSubViewController.dart';

class BasicTextDemo extends StatelessWidget {

  final TextStyle _customStyle = TextStyle(

    fontSize: 20,
    color: Colors.blue,

  );

  final _from = "网络";
  final _news = "新闻";

  Widget TextOneTest (){

    return  Text("$_from $_news:刚刚过去的全国两会，职业教育成为代表委员审议讨论的热词。今年的政府工作报告提出，加快发展现代职业教育，既有利于缓解当前就业压力，也是解决高技能人才短缺的战略举措。这明确了职业教育的地位和作用。",
      maxLines: 3,//行数
      overflow: TextOverflow.ellipsis,//省略号
      style: _customStyle,
    );
  }

  @override
//富文本
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return RichText(text: TextSpan(text: "Hello,Livesxu\n",style: TextStyle(fontSize: 20,color: Colors.red,),children: [
//      TextSpan(text: "my name is Livesxu",style: TextStyle(fontSize: 10,color: Colors.green))
//    ]));
//  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://b-ssl.duitang.com/uploads/item/201812/11/20181211022124_kurof.jpg"),
          alignment: Alignment.bottomCenter,
          repeat: ImageRepeat.repeatY,
//          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.blue.withOpacity(.4), BlendMode.hardLight)
        ),

      ),
//      color: Colors.grey[100],
      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: IconButton(icon: Icon(Icons.call,color: Colors.white,), onPressed: (){
              //跳转下一个页面
//              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomeSubHomeViewController(title:"NextVC")));
            Navigator.pushNamed(context, "/routerNameToNext");
            }),
//            color: Color.fromRGBO(3, 53, 255, 1),
            padding: EdgeInsets.all(10),//内边距
            margin: EdgeInsets.all(50),//外边距
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Color.fromRGBO(3, 53, 255, 1),
//              border: Border(top: BorderSide(color: Colors.greenAccent,width: 5)),//单边框
              border: Border.all(color: Colors.greenAccent,width: 5),//统一边框
//              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),//单圆角
//              borderRadius: BorderRadius.circular(20),//统一圆角
              boxShadow: [
                BoxShadow(color: Colors.green,offset: Offset(5, 10),blurRadius: 10,spreadRadius: 10)
              ],
              shape: BoxShape.circle,//形状，圆形的盒子上面不能使用圆角属性！
//              gradient:LinearGradient(colors: [Colors.red,Colors.blue],begin: Alignment.topCenter,end: Alignment.bottomCenter),//线性渐变
              gradient: RadialGradient(colors: [Colors.red,Colors.blue]),//星型渐变，辐射渐变
            ),
            
          ),
        ],
      ),
    );
  }
}
//rich  adj.丰富的
//span  n.范围
//blur  v.模糊
//spread v.展开
//gradient 斜坡 - 渐变
