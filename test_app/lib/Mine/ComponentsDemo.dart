import 'package:flutter/material.dart';

class ComponentsDemo extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ComponentsDemo"),
      ),
      body: ListView(
        children: <Widget>[

         ListItem(title:"FirstItem",page: NextPage(),),
         ListItem(title:"NextDemo",page: NextDemo(),),
         ListItem(title:"ThirdDemo",page: ThirdDemo(),),
        ],
      ),
      floatingActionButton: ThisFloatingAction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,//与底部bar重合居中位置

      bottomNavigationBar: BottomAppBar(//添加底部bar
        child: Container(
                 height: 40,
              ),
        shape: CircularNotchedRectangle(),//中间缺圆
      ),
    );
  }
}

class ThirdDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("ThirdDemo"),
      ),
      body: Theme(//将主体放在主题里面可以局部替换主题
          data: ThemeData(
            buttonColor: Colors.blue,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
//              shape: BeveledRectangleBorder(//斜面
//                borderRadius: BorderRadius.circular(10)
//              )
              shape: StadiumBorder()//体育场样式border
            )
          ),
          child: RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.print), label: Text("Print")),
      ),
    );
  }
}

class NextDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("NextDemo"),
      ),
//      body: FlatButton(onPressed: (){}, child: Text("button"),splashColor: Colors.red,),
//    body: FlatButton.icon(onPressed: (){}, icon: Icon(Icons.build), label: Text("Build")),
//    body: RaisedButton(onPressed: (){},child: Text("button"),color: Colors.green,),//默认有背景,默认填充主题里面buttonColor
//      body: RaisedButton.icon(onPressed: (){}, icon: Icon(Icons.print), label: Text("Print")),
//      body: Container(width: 150,child: OutlineButton.icon(onPressed: (){}, icon: Icon(Icons.print), label: Text("Print"),borderSide: BorderSide(color: Colors.red),),),
        body:Row(

          children: <Widget>[
            Expanded(child: OutlineButton.icon(onPressed: (){}, icon: Icon(Icons.print), label: Text("Print"),borderSide: BorderSide(color: Colors.red),),),
            Expanded(flex: 2,child: OutlineButton.icon(onPressed: (){}, icon: Icon(Icons.person), label: Text("Person"),borderSide: BorderSide(color: Colors.red),),)
          ],
        )
    );
  }
}

class ListItem extends StatelessWidget {

  final String title;
  final Widget page;

  ListItem({
    this.title,
    this.page,
  });

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(title),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}

class NextPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Next's title"),
      ),
    );
  }
}

class ThisFloatingAction extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      onPressed: (){},
      elevation: 0.0,
      backgroundColor: Colors.red,
      child: Icon(Icons.add),
      shape: BeveledRectangleBorder(//斜边形
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}

class TwoFloatingAction extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton.extended(
      onPressed: (){},
//      elevation: 0.0,
      backgroundColor: Colors.red,
      icon: Icon(Icons.add),
      label: Text("test"),
//      shape: BeveledRectangleBorder(//斜边形
//        borderRadius: BorderRadius.circular(30),
//      ),
    );
  }
}