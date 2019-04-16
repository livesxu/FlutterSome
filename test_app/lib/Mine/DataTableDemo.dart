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
      body: PaginatedDataTableExample(),
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


class PaginatedDataTableExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaginatedDataTableExampleState();
  }
}

class PaginatedDataTableExampleState extends State<PaginatedDataTableExample> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: ListView(
          children: <Widget>[
            PaginatedDataTable(
              header: Text("Header"),
                columns: [
//                DataColumn(label: Container(width: 100,child: Text("Id"),)),//设置宽度eg
                DataColumn(label: Text("Id")),
                DataColumn(label: Text("Title")),
                DataColumn(label: Text("Image")),
            ],source: DataTableSourceUsedExample())
          ],
        )
    );
  }
}

class DataTableSourceUsedExample extends DataTableSource {

  @override
  DataRow getRow(int index) {

    final Person person = Persons[index];

    return DataRow(selected:false,onSelectChanged: (bool){},cells: [
      DataCell(Text(person.id)),
      DataCell(Text(person.title)),
      DataCell(Image.network(person.body)),
    ]);
  }

  @override
  // TODO: implement rowCount
  int get rowCount => Persons.length;

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}