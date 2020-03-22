import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';
import '../public.dart';

Widget buildView(LoginState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppbarCommon(ctx: viewService.context,titleString: '登录',),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Image.asset('images_assets/icon.png',width: 60,height: 60,),
        ),
        SizedBox(height: 10,),
        ListTile(
          leading: Icon(Icons.account_circle,color: state.focusIndex == 1 ? Theme.of(viewService.context).primaryColor : Colors.black45,),
          title: TextField(
            controller: state.accountVc,
            decoration: InputDecoration(
              hintText: '请输入账号',
            ),
            onTap: (){dispatch(LoginActionCreator.focusAction(1));},
            onSubmitted: (string){ dispatch(LoginActionCreator.focusAction(0));},
          ),
        ),
        ListTile(
          leading: Icon(Icons.lock,color: state.focusIndex == 2 ? Theme.of(viewService.context).primaryColor : Colors.black45,),
          title: TextField(
            controller: state.passwordVc,
            obscureText: true,//*隐藏 - 密码模式
            decoration: InputDecoration(
              hintText: '请输入密码',
            ),
            onTap: (){dispatch(LoginActionCreator.focusAction(2));},
            onSubmitted: (string){ dispatch(LoginActionCreator.focusAction(0));},
          ),
        ),
        ListTile(
          trailing: InkWell(
            onTap: () => dispatch(LoginActionCreator.jumpRegister()),
            child: Text('注册',style: TextStyle(color: Colors.black45,fontSize: 16),),
          ),
        ),
        RaisedButton(
            padding: EdgeInsets.only(left: 50,right: 50),
            color: Theme.of(viewService.context).primaryColor,
            child: Text('确定',style: TextStyle(color: Colors.white,fontSize: 16),),
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(15))),
            onPressed: (){
              dispatch(LoginActionCreator.submitAction());
            }
        ),
        SizedBox(height: 100,)
      ],
    ),
  );
}
