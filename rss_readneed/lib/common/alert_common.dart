import 'package:flutter/material.dart';
import './consts.dart';

class Alert extends StatelessWidget {

  static List alertList = [];
  static bool isAlertShow = false;
  static OverlayState overlayStateCurrent;

  //添加普通展示内容
  static void addNomal(String title,String msg,VoidCallback sureCallback){

    OverlayEntry _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Alert(
          title: commonTitle(title),
          message: commonMessage(msg),
          actions: [commonCancelBtn('取消'),
                    commonSureBtn('确定', sureCallback)],

        )
    );
    alertList.add(_overlayEntry);
  }

  static void addAlert(Alert alert) {

    OverlayEntry _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => alert
    );
    alertList.add(_overlayEntry);
  }

  //展示弹框
  static void show(BuildContext context){

    OverlayState overlayState = Overlay.of(context);
    if (alertList.length > 0 && isAlertShow == false) {
      overlayStateCurrent = overlayState;
      overlayStateCurrent.insert(alertList.first);
      isAlertShow = true;
    }
  }

  //弹框消失
  static void dismiss() {

    if (alertList.length > 0 &&  isAlertShow == true) {

      OverlayEntry _overlayEntryCurrent = alertList.first;
      alertList.remove(_overlayEntryCurrent);
      _overlayEntryCurrent.remove();
      _overlayEntryCurrent = null;
      isAlertShow = false;

      if (overlayStateCurrent != null && alertList.length > 0) {

        overlayStateCurrent.insert(alertList.first);
        isAlertShow = true;
      } else {

        overlayStateCurrent = null;
      }
    }
  }

  //公共样式
  static Text commonTitle(String title) {

    return title == null ? null : Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black,decoration: TextDecoration.none,),);
  }

  static Widget commonMessage(String msg) {

    return msg == null ? null : Container(padding: EdgeInsets.only(top: 5,right: 15,left: 15,bottom: 5,),child: Text(msg,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black87,decoration: TextDecoration.none,),),);
  }

  static FlatButton commonCancelBtn(String cancelTitle) {

    return FlatButton(onPressed: (){Alert.dismiss();}, child: Text(cancelTitle,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black45),));
  }

  static FlatButton commonSureBtn(String sureTitle,VoidCallback sureCallback) {

    return FlatButton(onPressed: (){sureCallback(); }, child: Text(sureTitle,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blue),));
  }

  static Card commonTextField(TextField textField) {

    return Card(child: textField,elevation: 0,);
  }

  Alert({
    this.title,
    this.message,
    this.textField1,
    this.textField2,
    this.customView,
    this.actions,
  });

  final Text title;
  final Widget message;
  final Card textField1;
  final Card textField2;
  final Widget customView;
  final List<FlatButton> actions;

  @override
  Widget build(BuildContext context) {

    double screen_width = Consts.screenWidth > 500 ? 500 : Consts.screenWidth;
    double alert_s_w = screen_width - 60;//控制宽度

    List<Widget> widgets_c = [];
    widgets_c.add(SizedBox(height: 10,));
    widgets_c.add(title ?? Container());
    widgets_c.add(message ?? Container());
    widgets_c.add(textField1 ?? Container());
    widgets_c.add(textField2 ?? Container());
    widgets_c.add(customView ?? Container());

    //操作按钮
    if (actions != null && actions.length > 0) {

      List<Widget> actions_new = [];
      for (FlatButton action in actions) {

        Widget item = Container(
          width: alert_s_w/actions.length,
          child: action,
        );

        actions_new.add(item);
      }

      widgets_c.add(Row(children:actions_new,));
    }


    return Positioned(
        child: Container(
            color: Colors.black38,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: alert_s_w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                      children: widgets_c
                  ),
                ),
              ],
            )
        )
    );
  }
}