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

    //所在月设置信息
    PunchCardSettingModel monthModel = PunchCardSettingModel().getSettingsModel(dateTime.toString().substring(0,7));

    String settingFinishTime = monthModel.finishTime.substring(10);

    //是否统计
    bool inCount = dateTime.weekday < 6 ? true : false;

    if (monthModel.inCountSaturday && dateTime.weekday == 6) {

      inCount = true;
    } else if (monthModel.inCountSunday && dateTime.weekday == 7) {

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

  //当前时刻的设置信息
  static PunchCardSettingModel _instance;
  static PunchCardSettingModel get instance {

    if (_instance == null) {

      //先默认创建一个，因为异步数据可能还未获得
      _instance = PunchCardSettingModel().initModelWith(DateTime.now().toString().substring(0,7));

      PunchCardSettingModel().getModel(PunchCardModel().dateTimeString(DateTime.now()).substring(0,7)).then((PunchCardSettingModel model){

        _instance = model;
      });
    }
    return _instance;
  }

  //所有的设置信息
  static List<PunchCardSettingModel> _settings;
  static List<PunchCardSettingModel> get settings {

    if (_settings == null) {

      _settings = [];

      PunchCardSettingModel().getSettings().then((List<PunchCardSettingModel> settings){

        _settings = settings;
      });
    }
    return _settings;
  }

  //这个模式是在单例里面取，如果取不到那就用默认的补上使用
  PunchCardSettingModel getSettingsModel(String currentMonthTimeString) {

    for(PunchCardSettingModel model in PunchCardSettingModel.settings) {

      if (model.monthTime == currentMonthTimeString) {

        return model;
      }
    }
    return PunchCardSettingModel().initModelWith(currentMonthTimeString);
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

  //取出所在的月份的数据
  Future<List<PunchCardSettingModel>> getSettings() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String string = prefs.getString("punch_card_setting");

    if (string == null) {//如果不存在就返回新建数据,同时存储

      return [];
    }
    List list = json.decode(string);

    List<PunchCardSettingModel> models = list.map((map) => PunchCardSettingModel.fromJson(map)).toList();

    return models;
  }


  //取出所在的月份的数据
  Future<PunchCardSettingModel> getModel(String currentMonthTimeString) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String string = prefs.getString("punch_card_setting");

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
    DateTime lastMonthDate = DateTime.parse(currentMonthTimeString + "-01").subtract(Duration(days: 2));//拿到上个月的倒数第二天

    String lastMonthTimeString = lastMonthDate.toString().substring(0,7);

    PunchCardSettingModel lastModel;
    for(PunchCardSettingModel model in models) {

      if (model.monthTime == lastMonthTimeString) {

        lastModel = model;
        break;
      }
    }
    if (lastModel == null){//防范异常,上个月也不存在，那就新建
      return PunchCardSettingModel().initModelWith(currentMonthTimeString);
    }

    //以上个月的数据建立新的的数据
    PunchCardSettingModel model = PunchCardSettingModel(
      monthTime: currentMonthTimeString,
      startTime: lastModel.startTime,
      finishTime: lastModel.finishTime,
      finishNextDayTime: lastModel.finishNextDayTime,
      inCountSaturday:lastModel.inCountSaturday,
      inCountSunday:lastModel.inCountSunday,
    );

    models.add(model);

    prefs.setString("punch_card_setting",json.encode(models));

    return model;
  }

  //月度数据统计
  Future<List<PunchCardModel>> monthDatas (PunchCardSettingModel monthModel) async {

    List<PunchCardModel>monthDatas = [];

    //月度第一天
    DateTime monthFirstDay = DateTime.parse(monthModel.monthTime + "-01");

    //取下个月的第一天使用while语句  //月度最后一天   超过当月会指向下一个月第一天，再减一天
    DateTime monthLastDay = DateTime.parse(monthModel.monthTime + "-32");//.subtract(Duration(days: 1));

    //当天
    DateTime today = PunchCardModel().todayDateTime();
    //如果当天在月度之中，则取当天之前的数据捞取
    if (today.isBefore(monthLastDay)) {

      monthLastDay = today;
    }

    List<PunchCardModel> list = [];

    list = await PunchCardModel().getDatas();

    List<PunchCardModel> listTemp = [];//存储当月捞出的所有数据
    for (PunchCardModel model in list) {

      if (model.monthTime == monthModel.monthTime) {

        listTemp.add(model);
      }
    }

    while (monthFirstDay.isBefore(monthLastDay)) {

      bool haveData = false;
      //再遍历当月的数据集
      for (PunchCardModel model in listTemp) {

        if (DateTime.parse(model.dateTime) == monthFirstDay) {

          haveData = true;
          monthDatas.add(model);
          listTemp.remove(model);
          break;
        }
      }
      if (haveData == false) {//当天没有记录数据，则补充数据

        monthDatas.add(PunchCardModel().initModelWith(monthFirstDay));
      }
      monthFirstDay = monthFirstDay.add(Duration(days: 1));
    };
    return monthDatas;
  }
}

