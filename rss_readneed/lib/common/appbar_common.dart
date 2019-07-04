import 'package:flutter/material.dart';
import 'package:rss_readneed/common/appbar_gradient.dart';
/*统一appbar展示*/
class AppbarCommon extends GradientAppBar {

  String titleString;
  BuildContext ctx;
  List<Widget> actions;
  bool isNeedBack;
  AppbarCommon({
    @required this.ctx,
    this.titleString,
    this.actions,
    this.isNeedBack,
  }):super(title:Text(titleString,style: TextStyle(color: Colors.white,),),
        leading:CustomBackBtn(isNeedBack: isNeedBack,),
        actions:actions,
        shadowColor: Theme.of(ctx).primaryColor,
        gradient: RadialGradient(//更改为圆扩散
            colors: [Theme.of(ctx).primaryColorLight,Theme.of(ctx).primaryColorDark],
            center: Alignment.topLeft,
            radius: 4),
      ){assert(ctx != null);}
}

//自定义的返回按钮
class CustomBackBtn extends StatelessWidget {

  //强制添加返回按钮标记
  final isNeedBack;

  const CustomBackBtn({ Key key,this.isNeedBack }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));

    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;

    return IconButton(
      icon: SizedBox(
        width: 20,
        height: 20,
        child: (canPop || (isNeedBack != null && isNeedBack == true)) ? Image.asset("images_assets/back_btn_nav.png") : Container(),
      ),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        Navigator.maybePop(context);
      },
    );
  }
}