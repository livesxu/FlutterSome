import 'package:flutter/material.dart';
import 'package:test_app/Home/Person.dart';

Widget HomeDrawer (){

  return Drawer(elevation: 0,child: ListView(
    children: <Widget>[
      DrawHeaders(),

      ListTile(title: Text("Message",textAlign: TextAlign.right,),trailing: Icon(Icons.message),),
      ListTile(title: Text("News",textAlign: TextAlign.right),trailing: Icon(Icons.fiber_new),),
      ListTile(title: Text("Setting",textAlign: TextAlign.right),trailing: Icon(Icons.settings),),

    ],
  ),);
}

Widget DrawHeaders (){

  return UserAccountsDrawerHeader(
    accountName: Text("Name"),
    accountEmail: Text("Email"),
    currentAccountPicture: CircleAvatar(backgroundImage:NetworkImage("https://b-ssl.duitang.com/uploads/item/201812/11/20181211022124_kurof.jpg"),),
    decoration: BoxDecoration(color: Colors.red,image:DecorationImage(colorFilter: ColorFilter.mode(Colors.green.withOpacity(.3), BlendMode.hardLight),fit: BoxFit.cover,image: NetworkImage("https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1473705410,2083012287&fm=173&app=25&f=JPEG?w=570&h=351&s=33A7D8047C4672C6048BF70B030070DA"))),
  );
}

Widget HomeEndDrawer (){

  Widget _endDrawerItem (BuildContext context,int index){

    return Container(padding: EdgeInsets.all(5), child: Column(children: <Widget>[
      Image.network(Persons[index].body),
      SizedBox(height: 10,),
      Text(Persons[index].title),
    ],),);
  }

  return Container(width: 200,decoration: BoxDecoration(color: Colors.white), child: ListView.builder(itemBuilder: _endDrawerItem,itemCount: Persons.length,),);
}