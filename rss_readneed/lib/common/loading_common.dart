import 'package:flutter/material.dart';
// todo
class Loading {

  List<LoadingItem> items = [];



  static Loading _instance;
  static Loading get instance {



    return _instance;
  }

  static show (BuildContext ctx,) {

    LoadingItem(timeout: 15,flag: '');
  }
}

class LoadingItem {

  final int timeout;
  final String flag;

  LoadingItem({
    this.timeout = 15,
    this.flag = '',
  });

  OverlayEntry _overlayEntry;
  bool _showing = false;
  DateTime _startedTime;

  void show (BuildContext ctx,Widget widget) async {

    _startedTime = DateTime.now();

    //获取OverlayState
    OverlayState overlayState = Overlay.of(ctx);
    _showing = true;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) =>
              Positioned(
//top值，可以改变这个值来改变toast在屏幕中的位置
                top: MediaQuery
                    .of(context)
                    .size
                    .height / 2 - 50.0,
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.0),
                      child: AnimatedOpacity(
                        opacity: _showing ? 0.7 : 0.0, //目标透明度
                        duration: _showing
                            ? Duration(milliseconds: 100)
                            : Duration(milliseconds: 400),
                        child: widget,
                      ),
                    )),
              ));
      overlayState.insert(_overlayEntry);
    } else {
      //重新绘制UI，类似setState
      _overlayEntry.markNeedsBuild();
    }

    await Future.delayed(Duration(milliseconds: 1000 * timeout));

    if (DateTime.now().difference(_startedTime).inMilliseconds >= 1000 * timeout) {
      _showing = false;
      _overlayEntry.remove();
      _overlayEntry = null;
    }

  }

  void hide () {

    _showing = false;
    _overlayEntry.remove();
    _overlayEntry = null;
  }
}