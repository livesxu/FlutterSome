import 'package:flutter/material.dart';
import 'package:test_app/Home/Person.dart';

class DataTableDemo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DataTableDemoState();
  }
}

class DataTableDemoState extends State<DataTableDemo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("DataTableDemo"),),
      body: DataTableExample(),
    );
  }
}

class DataTableExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DataTableExampleState();
  }
}

class DataTableExampleState extends State<DataTableExample> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView(
            children: <Widget>[
              DataTable(columns: [
//                DataColumn(label: Container(width: 100,child: Text("Id"),)),//设置宽度eg
                DataColumn(label: Text("Id")),
                DataColumn(label: Text("Title")),
                DataColumn(label: Text("Image")),
              ], rows:Persons.map((Person person){
                return DataRow(selected:false,onSelectChanged: (bool){},cells: [
                  DataCell(Text(person.id)),
                  DataCell(Text(person.title)),
                  DataCell(Image.network(person.body)),
                ]);
              }).toList())
            ],
          )
      );
  }
}