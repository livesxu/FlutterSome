import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PunchCardModel {

  final String yearTime;//年度划分2019
  final String monthTime;//月度划分2019-08
  final String dateTime;//天数划分2019-08-07
  final List<String> todayThings;//当天事项 已完成标记 添加前缀 over|
  final String finishTime;//结束工作时间
  final String workingThings;//工作内容
  final List<String> tomorrowThings;//明日事项 - 结转为当天事项
  final bool inCount;// 1:统计  是否统计 - 默认逻辑1-5统计，6-7不统计

  PunchCardModel({

    this.yearTime,
    this.monthTime,
    this.dateTime,
    this.todayThings,
    this.finishTime,
    this.workingThings,
    this.tomorrowThings,
    this.inCount,
  });

  //实例对象属性赋值
  PunchCardModel.fromJson(Map json)
      : yearTime = json["yearTime"],
        monthTime = json["monthTime"],
        dateTime = json["dateTime"],
        todayThings = json["todayThings"],
        finishTime = json["finishTime"],
        workingThings = json["workingThings"],
        tomorrowThings = json["tomorrowThings"],
        inCount = json["inCount"];

//encode会自动执行model 里面的toJson
  Map toJson() => {

    "yearTime":yearTime,
    "monthTime":monthTime,
    "dateTime":dateTime,
    "todayThings":todayThings,
    "finishTime":finishTime,
    "workingThings":workingThings,
    "tomorrowThings":tomorrowThings,
    "inCount":inCount,
  };

  PunchCardModel initModelWith(DateTime dateTime) {

    String dateString = PunchCardModel().dateTimeString(dateTime);
    //是否当天 - 当天则取当前时间,否则取下午6点（早9晚6，暂行基准）
    bool isToday = PunchCardModel().isToday(dateString);

    return PunchCardModel(
      yearTime: dateString.substring(0,4),
      monthTime: dateString.substring(0,7),
      dateTime: dateString,
      todayThings: [],
      finishTime: isToday ? PunchCardModel().timeString(DateTime.now()) : dateString + " 18:00:00",
      workingThings: "",
      tomorrowThings: [],
      inCount:dateTime.weekday < 6 ? true : false,
    );
  }


//所有数据
  Future<void> save(String datas) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("punch_card_in",datas);
  }

  Future<List<PunchCardModel>> getDatas() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String string = prefs.getString("punch_card_in");

    if (string == null) {//如果不存在就返回空数组

      return [];
    }

    List<PunchCardModel> list = json.decode(string);
    return list;
  }

//明日之星数据
  Future<void> saveTomorrowThings(List<String> datas) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("punch_card_in_tomorrows", datas);
  }

  Future<List<String>> getTomorrowThings() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList("punch_card_in_tomorrows");
  }

  //获取当天日期 - 年月日
  DateTime todayDateTime() {

    DateTime dateTime = DateTime.now();//当天时间

    DateTime beforeDateTime = dateTime.subtract(Duration(hours: 9));//用当前时间减去9小时（早9晚6，暂行基准），比对天是不是一样，不一样则算是前一天(涉夜加班)

    return DateTime(beforeDateTime.year,beforeDateTime.month,beforeDateTime.day);
  }

//  2012-02-27
  String dateTimeString(DateTime dateTime) {

    return dateTime.toString().substring(0,10);
  }

  bool isToday (String dateString) {

    DateTime dateTime = DateTime.now();//当天时间

    DateTime beforeDateTime = dateTime.subtract(Duration(hours: 9));//用当前时间减去9小时，比对天是不是一样，不一样则算是前一天(涉夜加班)

    String currentDateString = PunchCardModel().dateTimeString(beforeDateTime);

    if (dateString == currentDateString) {

      return true;
    } else {

      return false;
    }
  }

//  2012-02-27 13:27:00
  String timeString(DateTime dateTime) {

    return dateTime.toString().substring(0,19);
  }
}

