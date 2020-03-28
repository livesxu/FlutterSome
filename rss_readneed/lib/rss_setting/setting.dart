import 'package:flutter/material.dart';
import '../public.dart';


class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCommon(ctx: context,titleString: '设置',),
      body: ListView(
        children: <Widget>[
//          ListTile(leading: ,)
        ],
      ),
    );
  }
}
