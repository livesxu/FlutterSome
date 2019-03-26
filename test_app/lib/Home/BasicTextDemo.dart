import 'package:flutter/material.dart';

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

  Widget build(BuildContext context) {
    // TODO: implement build
    return RichText(text: TextSpan(text: "Hello,Livesxu\n",style: TextStyle(fontSize: 20,color: Colors.red,),children: [
      TextSpan(text: "my name is Livesxu",style: TextStyle(fontSize: 10,color: Colors.green))
    ]));
  }
}
//rich  adj.丰富的
//span  n.范围
