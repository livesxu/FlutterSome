import 'package:flutter/material.dart';
import '../public.dart';

import 'dart:io';

import '../common/photo_common.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../mainAppFlutterRedux/state.dart';
import '../mainAppFlutterRedux/action.dart';

class Setting extends StatefulWidget {

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> with Login {

  Widget _headerImg (String link) {

    Widget childWidget = ImageCommon.withUrl(Account.share.headImg,"images_assets/icon.png", () => this.judgeLogin(context, ()=> _headerTouchAction()));

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        width: 40,
        height: 40,
        color: Colors.white,
        child: childWidget,
      ),
    );
  }
  //点击头像
  _headerTouchAction () async {

    String img_url = await Photo.chooseAndUploadImage(context,'header_img');

    if (img_url == null) {

      return ;
    }

    ResuestResult result = await RequestCommon.Put('/login', {'phone':Account.share.phone,"headImg":img_url});

    if (result.success) {

      Account.share.headImg = img_url;
      Account.writeInfo();
      setState(() {

      });
    } else {

      Toast.show(context, '更新失败');
    }
  }

  //修改昵称
  _changeNickName () {

    TextEditingController controller = TextEditingController();
    Alert.addAlert(Alert(
      title: Alert.commonTitle('修改昵称'),
      textField1:Alert.commonTextField(TextField(controller: controller,decoration: InputDecoration(hintText: '请输入新昵称',),)),
      actions: [Alert.commonCancelBtn('取消'),Alert.commonSureBtn('确定', (){

        if (controller.text.length > 0) {

          _changeNickNameRequest(controller.text);
        } else {
          Toast.show(context, '请输入新昵称');
        }
      })],
    ));
    Alert.show(context);
  }

  Future<bool> _changeNickNameRequest (String nick) async {

    ResuestResult result = await RequestCommon.Put('/login', {'phone':Account.share.phone,"nick":nick});

    if (result.success) {
      Account.analysisInfo(result.body);
      Toast.show(context, '修改成功');
      setState(() {

      });
    }
    Alert.dismiss();
  }

  //选择主题
  _chooseTopic() {

    List<Widget> themeWidgets = themeColors.map((MaterialColor color){
      return FlatButton(onPressed: (){
        Store<AppState> state = StoreProvider.of(context);
        state.dispatch(AppAction.topicAction(color));
        Alert.dismiss();
      }, child: Container(padding: EdgeInsets.all(20),decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),color:color)));
    }).toList();

    Alert.addAlert(Alert(
      customView: Column(
        children: themeWidgets,
      ),
    ));
    Alert.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCommon(ctx: context,titleString: '设置',),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: _headerImg(Account.share.headImg),
            trailing: Icon(Icons.navigate_next),
            onTap: ()=> this.judgeLogin(context, ()=> _headerTouchAction()),
          ),
          ListTile(
            leading: Text(Account.share.nick??"昵称",style: TextStyle(fontSize: 16),),
            trailing: Icon(Icons.navigate_next),
            onTap: ()=> this.judgeLogin(context, ()=> _changeNickName()),
          ),
          ListTile(
            leading: Text("主题",style: TextStyle(fontSize: 16),),
            trailing: Icon(Icons.navigate_next),
            onTap: ()=> _chooseTopic(),
          ),
          ListTile(
            leading: Text("清理缓存",style: TextStyle(fontSize: 16),),
            trailing: Icon(Icons.navigate_next),
            onTap: ()=> DefaultCacheManager().emptyCache(),
          ),
          ListTile(
            leading: Text("分享",style: TextStyle(fontSize: 16),),
            trailing: Icon(Icons.navigate_next),
//            onTap: ()=> , todo
          ),
          ListTile(
            leading: Text('关于我们',style: TextStyle(fontSize: 16),),
            trailing: Icon(Icons.navigate_next),
//            onTap: ()=> , todo
          ),
          SizedBox(height: 50,),
          Container(
            margin: EdgeInsets.only(left: 50,right: 50),
            height: 50,
            child: Account.isLogin ? RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Text('退出登录',style: TextStyle(color: Colors.white,fontSize: 20),),
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(25))),
                onPressed: (){
                  Account.clearInfo();
                  Navigator.pop(context,true);//退出并更新数据
                }
            ) : Container(),
          ),

        ],
      ),
    );
  }
}
