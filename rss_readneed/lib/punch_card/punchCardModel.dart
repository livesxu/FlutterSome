import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PunchCardModel {

  final String yearTime;//年度划分2019
  final String monthTime;//月度划分2019-08
  final String dateTime;//天数划分2019-08-07
  final List todayThings;//当天事项 已完成标记 添加前缀 over|
  final String finishTime;//结束工作时间
  final String workingThings;//工作内容
  final List tomorrowThings;//明日事项 - 结转为当天事项
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

    String settingFinishTime = PunchCardSettingModel.instance.finishTime.substring(10);

    //是否统计
    bool inCount = dateTime.weekday < 6 ? true : false;

    if (PunchCardSettingModel.instance.inCountSaturday && dateTime.weekday == 6) {

      inCount = true;
    } else if (PunchCardSettingModel.instance.inCountSunday && dateTime.weekday == 7) {

      inCount = true;
    }

    return PunchCardModel(
      yearTime: dateString.substring(0,4),
      monthTime: dateString.substring(0,7),
      dateTime: dateString,
      todayThings: [],
      finishTime: isToday ? PunchCardModel().timeString(DateTime.now()) : dateString + settingFinishTime,
      workingThings: "",
      tomorrowThings: [],
      inCount:inCount,
    );
  }


//所有数据
  Future<void> save(PunchCardModel model,bool isChange) async {

    Future<List<PunchCardModel>> datas = PunchCardModel().getDatas();

    datas.then((List<PunchCardModel> list) async {

      if (list == null) return ;

      if (isChange) {

        for (PunchCardModel model1 in list) {

          if (model1.dateTime == model.dateTime) {

            list.remove(model1);
            break;
          }
        }
        list.add(model);

      } else {

        list.add(model);
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString("punch_card_in",json.encode(list));
    });
  }

  Future<List<PunchCardModel>> getDatas() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String string = prefs.getString("punch_card_in");

    if (string == null) {//如果不存在就返回空数组

      return [];
    }

    List list = json.decode(string);

    return list.map((map) => PunchCardModel.fromJson(map)).toList();
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

    //获取到上班时间 用当前时间减去 确定为今天
    DateTime startTime = DateTime.parse(PunchCardSettingModel.instance.startTime);

    DateTime beforeDateTime = dateTime.subtract(Duration(hours: startTime.hour,minutes: startTime.minute));//用当前时间减去9小时（早9晚6，暂行基准）

    return DateTime(beforeDateTime.year,beforeDateTime.month,beforeDateTime.day);
  }

//  2012-02-27
  String dateTimeString(DateTime dateTime) {

    return dateTime.toString().substring(0,10);
  }

  bool isToday (String dateString) {

    DateTime dateTime = DateTime.now();//当天时间

    //获取到涉夜加班的截止点 用当前时间减去，比对天是不是一样，不一样则算是前一天(涉夜加班)
    DateTime finishNextDayTime = DateTime.parse(PunchCardSettingModel.instance.finishNextDayTime);

    DateTime beforeDateTime = dateTime.subtract(Duration(hours: finishNextDayTime.hour,minutes: finishNextDayTime.minute));//用当前时间减去9小时，比对天是不是一样，不一样则算是前一天(涉夜加班)

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

//月度设置项存储
class PunchCardSettingModel {

  final String monthTime;//月度划分2019-08

  final String startTime;//开始工作时间  - 2019-08-07 09:00:00  裁剪展示
  final String finishTime;//结束工作时间  - 2019-08-07 18:00:00 裁剪展示
  final String finishNextDayTime;//隔天加班截止的第二天时间点     裁剪展示

  final bool inCountSaturday;// 1:统计  是否统计 - 默认逻辑1-5统计，6-7不统计
  final bool inCountSunday;// 1:统计  是否统计 - 默认逻辑1-5统计，6-7不统计

  PunchCardSettingModel({

    this.monthTime,
    this.startTime,
    this.finishTime,
    this.finishNextDayTime,
    this.inCountSaturday,
    this.inCountSunday,
  });

  //实例对象属性赋值
  PunchCardSettingModel.fromJson(Map json)
      : monthTime = json["monthTime"],
        startTime = json["startTime"],
        finishTime = json["finishTime"],
        finishNextDayTime = json["finishNextDayTime"],
        inCountSaturday = json["inCountSaturday"],
        inCountSunday = json["inCountSunday"];

//encode会自动执行model 里面的toJson
  Map toJson() => {

    "monthTime":monthTime,
    "startTime":startTime,
    "finishTime":finishTime,
    "finishNextDayTime":finishNextDayTime,
    "inCountSaturday":inCountSaturday,
    "inCountSunday":inCountSunday,
  };

  static PunchCardSettingModel _instance;
  static PunchCardSettingModel get instance {

    if (_instance == null) {

      PunchCardSettingModel().getModel().then((PunchCardSettingModel model){

        _instance = model;
      });
    }
    return _instance;
  }

  PunchCardSettingModel initModelWith(String monthTime) {

    return PunchCardSettingModel(
      monthTime: monthTime,
      startTime: "2019-08-07 09:00:00",  //默认早上 9
      finishTime: "2019-08-07 18:00:00", //默认晚上 6
      finishNextDayTime: "2019-08-07 09:00:00",  //默认早上 9
      inCountSaturday:false,   //默认周六不上班
      inCountSunday:false,     //默认周日不上班
    );
  }


//更改存储
  Future<void> save(PunchCardSettingModel model) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String string = prefs.getString("punch_card_setting");

    List list = json.decode(string);

    List<PunchCardSettingModel> models = list.map((map) => PunchCardSettingModel.fromJson(map)).toList();

    for (PunchCardSettingModel model1 in models) {

      if (model1.monthTime == model.monthTime) {

        list.remove(model1);
        break;
      }
    }
    list.add(model);

    prefs.setString("punch_card_setting",json.encode(models));
  }

  //取出当前所在的月份
  Future<PunchCardSettingModel> getModel() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String string = prefs.getString("punch_card_setting");

    //获取当前所在的月
    String currentMonthTimeString = PunchCardModel().dateTimeString(DateTime.now()).substring(0,7);

    if (string == null) {//如果不存在就返回新建数据,同时存储

      PunchCardSettingModel model = PunchCardSettingModel().initModelWith(currentMonthTimeString);

      List list = []
                    ..add(model);

      prefs.setString("punch_card_setting",json.encode(list));

      return PunchCardSettingModel().initModelWith(currentMonthTimeString);
    }

    List list = json.decode(string);

    List<PunchCardSettingModel> models = list.map((map) => PunchCardSettingModel.fromJson(map)).toList();

    for(PunchCardSettingModel model in models) {

      if (model.monthTime == currentMonthTimeString) {

        return model;
      }
    }

    //没有找到，那就以上个月为模板创建一份数据 - 同时存下来
    PunchCardSettingModel model = PunchCardSettingModel().initModelWith(currentMonthTimeString);

    models.add(model);

    prefs.setString("punch_card_setting",json.encode(models));

    return model;
  }
}

