import 'package:flutter/material.dart';

//loading -
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
/*页面拉取数据的loading规划展示*/
typedef Future<void> LoadingThing();
typedef Widget ShowChild();

class LoadingSupport extends StatefulWidget {

  final bool isForwardLoading;//是否向前展示 - loading在页面展示之上

  final LoadingThing loadingThings;//future操作

  final ShowChild showChild;//展示页面操作

  final Widget loadingPage;//loading页面

  LoadingSupport({

    GlobalKey<LoadingSupportState> key,
    this.isForwardLoading,
    this.loadingPage,
    this.loadingThings,
    @required this.showChild,
  })
      : super(key: key) {
    assert(showChild != null);
    }

  // 获取键
  GlobalKey<LoadingSupportState> getKey() {
  return this.key;
  }

  @override
  LoadingSupportState createState() => new LoadingSupportState();
}

class LoadingSupportState extends State<LoadingSupport> {

  bool _showLoading;

  void showLoading () {

    setState(() {
      _showLoading = true;
    });
  }

  void endLoading () {

    setState(() {
      _showLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return judgeWidget();
  }

  Widget judgeWidget () {

    if (_showLoading) {

      Widget loadingView = (widget.loadingPage != null) ? widget.loadingPage : Center(child: Loading(indicator: BallSpinFadeLoaderIndicator()),);
      if (widget.isForwardLoading != null && widget.isForwardLoading == true) {

        return Stack(
          children: <Widget>[
            widget.showChild(),
            loadingView
          ],
        );

      } else {

        return loadingView;
      }
    } else {

      return widget.showChild();
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.loadingThings != null) {

      _showLoading = true;

      Future futureDatas = widget.loadingThings();

      if (futureDatas != null) {

        futureDatas.then((_){

          endLoading();
        });
      }

    } else {

      _showLoading = false;
    }
  }
}