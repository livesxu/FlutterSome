//
// Generated file. Do not edit.
//
import 'dart:ui';

import 'package:location_web/location_web.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void registerPlugins(PluginRegistry registry) {
  LocationWebPlugin.registerWith(registry.registrarFor(LocationWebPlugin));
  SharedPreferencesPlugin.registerWith(registry.registrarFor(SharedPreferencesPlugin));
  registry.registerMessageHandler();
}
