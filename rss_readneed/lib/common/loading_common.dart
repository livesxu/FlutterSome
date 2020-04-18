import 'package:flutter/material.dart';
import './consts.dart';

//loading -
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';

class LoadingCommon extends StatelessWidget {

  static int _loadingCount = 0;
  static OverlayEntry _overlayEntryCurrent;

  static bool get loading {

    bool temp =  _loadingCount > 0;

    if (!temp) {

      _loadingCount = 0;
    }
    return temp;
  }
  //todo 锁
  //展示弹框
  static void show(BuildContext context,bool mask){

    OverlayState overlayState = Overlay.of(context);
    if (loading) {
      _loadingCount  += 1;

    } else {
      _loadingCount  += 1;

      //延时0.3s执行,如果.3秒之内请求完成则不闪烁loading
      Future.delayed(Duration(milliseconds: 300),(){

        if (loading) {

          _overlayEntryCurrent = OverlayEntry(
              builder: (BuildContext context) => LoadingCommon(isMask: mask,)
          );
          overlayState.insert(_overlayEntryCurrent);
        }
      });
    }
  }

  //弹框消失
  static void dismiss() {

    _loadingCount -= 1;
    if (!loading && _overlayEntryCurrent != null) {
      _overlayEntryCurrent.remove();
      _overlayEntryCurrent = null;
    }
  }

  static Widget forwardLoading(Widget showWidget) {

    return Stack(
       children: <Widget>[
         showWidget,
         Center(child: commonItem(),)
       ],
    );
  }

  LoadingCommon({
    this.isMask,
  });

  final bool isMask;

  @override
  Widget build(BuildContext context) {

    double topFlag = 0;
    double leftFlag = 0;
    double widthFlag = Consts.screenWidth;
    double heightFlag = Consts.screenHeight;
    if (!isMask) {

      topFlag = Consts.screenHeight/2 - 30;
      leftFlag = Consts.screenWidth/2 - 30;
      widthFlag = 60;
      heightFlag = 60;
    }

    return Positioned(
      top: topFlag,left: leftFlag,width: widthFlag,height: heightFlag,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(isMask ? 0 : 5)),
              color: Colors.black38,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                      children: [commonItem()]
                  ),
                ),
              ],
            )
        )
    );
  }

  static Widget commonItem () {

    return Loading(indicator: BallSpinFadeLoaderIndicator());
  }
}

