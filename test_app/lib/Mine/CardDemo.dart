import 'package:flutter/material.dart';
import 'package:test_app/Home/Person.dart';

class CardDemo extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CardDemoState();
  }
}

class CardDemoState extends State<CardDemo> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("CardDemo"),),
      body: CardDemoExample(),
    );
  }
}

class CardDemoExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CardDemoExampleState();
  }
}

class CardDemoExampleState extends State<CardDemoExample> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(children: Persons.map((Person person){

      return Card(
        child: Column(
          children: <Widget>[
            AspectRatio(aspectRatio: 16/9,child: ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(4),topRight: Radius.circular(4)),child: Image.network(person.body,fit: BoxFit.cover,),),),
            ListTile(leading: CircleAvatar(backgroundImage: NetworkImage(person.body),),title: Text(person.id),subtitle: Text(person.title),),
            Container(padding: EdgeInsets.all(16),child: Text("我是一个简介非常长的简介，请给我点赞，6666.很高兴见到你，我亲爱的朋友。${person.userId}"),),
            Row(mainAxisAlignment: MainAxisAlignment.end,children: <Widget>[
              FlatButton(onPressed: (){}, child: Text("DisLike",style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w700),)),
              FlatButton(onPressed: (){}, child: Text("Like",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w700),)),
            ],)
          ],
        ),

      );

    }).toList(),);
  }
}

