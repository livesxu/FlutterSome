import 'package:flutter/material.dart';

class HomeSubHomeViewController extends StatelessWidget {

  final String title;

  HomeSubHomeViewController ({

    this.title,

  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title),

      ),
      body: FloatingActionButton(child: Icon(Icons.arrow_back),onPressed: (){Navigator.pop(context);}),
    );
  }
}