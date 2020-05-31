import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'state.dart';
import 'action.dart';
import '../public.dart';

final Reducer<AppState> appReducer = combineReducers([
  new TypedReducer<AppState, ThemeDataAction>(themeReducer),
  new TypedReducer<AppState, AccountAction>(accountReducer),
]);

final themeReducer = (AppState state, ThemeDataAction data) {

  ThemeManager.analysisInfo(data.color);

  ThemeManager.themeData = ThemeManager.themeFrom(data.color);

  return state
            ..themeData = ThemeManager.themeData;
};

final accountReducer = (AppState state, AccountAction data) {

  return state
    ..account = Account.share;
};