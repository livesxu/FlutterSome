import 'package:flutter/material.dart';
import 'package:test_app/Home/Person.dart';

class ViewDemo extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return GridViewBuilderDemo();
  }
}


class GridViewBuilderDemo extends StatelessWidget {

  Widget _BuildItem (BuildContext context,int index){

    return Container(
      child: Image(image: NetworkImage(Persons[index].body),fit: BoxFit.cover,alignment: Alignment.center,),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 10,mainAxisSpacing: 10), itemBuilder: _BuildItem,itemCount: Persons.length,padding: EdgeInsets.all(10),);
  }
}


class GridViewCountDemo extends StatelessWidget {
  //list创建方式！！
  List<Widget> _GridViews(int length) {

    return List.generate(length, (int index){

      return Container(
        padding: EdgeInsets.all(10),
        child: Image(image: NetworkImage(Persons[index].body),fit: BoxFit.cover,alignment: Alignment.center,),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(crossAxisCount: 3,children: _GridViews(Persons.length),);
  }
}


class PageViewBuilderDemo extends StatelessWidget {

  Widget _PageViewBuilderItem (BuildContext context,int index) {

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
//        Image(image: NetworkImage(Persons[index].body),fit: BoxFit.cover,alignment: Alignment.center,),
      //.expand扩展到整个可用空间
        SizedBox.expand(child: Image(image: NetworkImage(Persons[index].body),fit: BoxFit.cover,alignment: Alignment.center,),),
//        Text(Persons[index].title,textAlign: TextAlign.left,),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(Persons[index].title,style: TextStyle(fontWeight: FontWeight.bold),),
              Text(Persons[index].userId)
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PageView.builder(itemBuilder: _PageViewBuilderItem,itemCount: Persons.length,scrollDirection: Axis.horizontal,controller: PageController(initialPage: 1,keepPage: false,viewportFraction: .8),pageSnapping: true,onPageChanged: (int index){print("$index");},);
  }

}

