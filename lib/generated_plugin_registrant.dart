//
// Generated file. Do not edit.
//

// ignore: unused_import
import 'dart:ui';

import 'package:location_web/location_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(PluginRegistry registry) {
  LocationWebPlugin.registerWith(registry.registrarFor(LocationWebPlugin));
  UrlLauncherPlugin.registerWith(registry.registrarFor(UrlLauncherPlugin));
  registry.registerMessageHandler();
}