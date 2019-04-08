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

class NextDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("NextDemo"),
      ),
//      body: FlatButton(onPressed: (){}, child: Text("button"),splashColor: Colors.red,),
    body: FlatButton.icon(onPressed: (){}, icon: Icon(Icons.build), label: Text("Build")),
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