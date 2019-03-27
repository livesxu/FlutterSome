import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,//主轴
      crossAxisAlignment: CrossAxisAlignment.center,//交叉轴（主轴垂直）
      children: <Widget>[
        Stack(children: <Widget>[
          SizedBox(width: 100,height: 50,child: Container(
            alignment: Alignment(1, -1),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),
            child: Icon(Icons.flag,color: Colors.white,)
            ,),),
          SizedBox(width: 20,),
          SizedBox(child: Icon(Icons.call_missed_outgoing),),
          Positioned(child: Icon(Icons.cached,),left: 20,top: 10,),
        ],),
        AspectRatioTest(),
        ConstrainedBox(constraints: BoxConstraints(maxHeight: 100,minWidth: 100),child: Container(color: Colors.blue,),),
      ],
    );
  }
}

Widget AspectRatioTest (){

  return SizedBox(width: 100,height: 200,child: Stack(children: <Widget>[
    AspectRatio(aspectRatio: 1,child:Container(color: Colors.red,),),
    Container(child: Icon(Icons.title),alignment: Alignment(1, 1),),
    Positioned(child: Container(child: Icon(Icons.settings,color: Colors.white,),color: Colors.green,),left: 10,top: 10,width: 80,height: 80,)
  ],),);
//  return AspectRatio(aspectRatio: 0.2,child:Container(child: SizedBox(width: 100,child: Container(color: Colors.red,),),));
}








class IconBadge extends StatelessWidget {

  final IconData icon;
  final double size;

  IconBadge(this.icon,{
    this.size = 32,

  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Icon(icon,size: size,color: Colors.white,),
      width: size+60,
      height: size +60,
      color: Colors.blue,
    );
  }
}

//stretch 铺开