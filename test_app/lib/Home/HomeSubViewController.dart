import 'package:flutter/material.dart';
import 'package:test_app/Home/Person.dart';

class HomeSubHomeViewController extends StatelessWidget {

  final String title;
  final Person person;

  HomeSubHomeViewController ({

    this.title,
    this.person,

  });

  String _getTitleName() {

    String nameStand;

    if (title != null && title.length > 0) {

      nameStand = title;
    } else {

      nameStand = person.title;
    }

    return nameStand;
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitleName()),

      ),
      body: Stack(children: <Widget>[
        Column(children: <Widget>[
          Image.network(person.body),
          Padding(padding: EdgeInsets.only(left: 10),child: Text(person.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),),
          Text(person.userId,style:TextStyle(color: Colors.grey),),

        ],crossAxisAlignment: CrossAxisAlignment.start,),
        Positioned(child: Container(child: FloatingActionButton(child: Icon(Icons.arrow_back),onPressed: (){Navigator.pop(context);}),),bottom: 10,right: 10,)
      ],)


    );
  }
}