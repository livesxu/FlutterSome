import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeDemo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DateTimeDemoState();
  }
}

class DateTimeDemoState extends State<DateTimeDemo> {
  
  DateTime time = DateTime.now();

  _dateSelectAction () async {

    DateTime timeSelected = await showDatePicker(
      context: context,
      initialDate: time,
      firstDate: DateTime(1900),
      lastDate: DateTime(2099),
    );

    if (timeSelected == null) return;

    setState(() {
      time = timeSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("DateTimeDemo"),),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        InkWell(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(DateFormat.yMd().format(time)),
            Icon(Icons.arrow_drop_down),
          ],),
          onTap: _dateSelectAction,
        )
      ],
      ),
    );
  }
}