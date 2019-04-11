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

  TimeOfDay dayTime = TimeOfDay.now();

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
  //未来某个时间点返回 - Future标记
  Future<void> _timeSelectAction () async {

    TimeOfDay timeSelected = await showTimePicker(context: context, initialTime: dayTime);

    if (timeSelected == null) return;

    setState(() {
      dayTime = timeSelected;
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
        ),
        InkWell(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(dayTime.format(context)),
            Icon(Icons.arrow_drop_down),
          ],),
          onTap: _timeSelectAction,
        )
      ],
      ),
    );
  }
}