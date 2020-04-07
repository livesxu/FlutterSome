import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'state.dart';
import 'action.dart';
import '../public.dart';

AppState appReducer (AppState state, action) {

  return AppState(
    account: accountReducer(state.account,action),
    themeData: themeReducer(state.themeData,action),
  );
}

final accountReducer = combineReducers<AccountModel>([
  TypedReducer<AccountModel,AccountModel>((oldAccount,newAccount){
    oldAccount = newAccount;
    return oldAccount;
  }),
]);

final themeReducer = combineReducers<ThemeData>([
  TypedReducer<ThemeData,ThemeData>((oldThemeData,newThemeData){
    oldThemeData = newThemeData;
    return oldThemeData;
  }),
]);

