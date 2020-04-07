import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../public.dart';
import 'package:flutter/material.dart';

mixin Login {

  void judgeLogin (BuildContext context,VoidCallback voidAction) async {

    if (Account.isLogin == false) {

      final backInfo = await Navigator.of(context).push(MaterialPageRoute(builder:(_) => AppNavigator.routePage('login')));

      print("back_____" + backInfo.toString());
      if (backInfo != null && voidAction != null && backInfo['success'] == true) {

        voidAction();
      }
    } else if (voidAction != null) {

      voidAction();
    }
  }
}

class Account {

    static bool isLogin = false;

    static AccountModel _share;
    static AccountModel get share {

      if (_share == null)  {

        _share = AccountModel();

      }
      return _share;
    }

    //读取数据
    static readInfo (SharedPreferences prefs) async {

      String accountInfo = prefs.get('account');

      if (accountInfo == null || accountInfo.length == 0) { //如果不存在就返回空

        _share = AccountModel();
      } else {

        _share = AccountModel.fromJson(json.decode(accountInfo));
        isLogin = true;
      }
    }

    //储存数据
    static writeInfo() async {

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('account', json.encode(_share));

    }

    //清理登录信息
    static clearInfo() async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('account', '');

      _share = AccountModel();
      isLogin = false;
    }

    //解析存储数据
    static analysisInfo(Map info){

      _share = AccountModel.fromJson(info);
      isLogin = true;
      Account.writeInfo();
    }
}

class AccountModel {

  AccountModel({this.userId});

  int userId;//用户id
  String phone;//手机号
  String nick;//昵称
  String introduce;//介绍
  String headImg;//头像
  int level;//等级
  int vip;//会员
  String auth;//认证

  AccountModel.fromJson(Map json)
    :   userId = json['userId'],
        phone = json['phone'],
        nick = json['nick'],
        introduce = json['introduce'],
        headImg = json['headImg'],
        level = json['level'],
        vip = json['vip'],
        auth = json['auth'];

  Map toJson() =>
      {
        'userId':userId,
        'phone':phone,
        'nick':nick,
        'introduce':introduce,
        'headImg':headImg,
        'level':level,
        'vip':vip,
        'auth':auth
      };
}