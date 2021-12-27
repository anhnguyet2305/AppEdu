import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_edu/feature/injector_container.dart' as di;
import 'package:flutter/services.dart';
import 'feature/app.dart';

dynamic decodeIsolate(String response) => jsonDecode(response);

dynamic endCodeIsolate(dynamic json) => jsonEncode(json);

dynamic parseJson(String text) => compute(decodeIsolate, text);

dynamic endCodeJson(dynamic json) => compute(endCodeIsolate, json);

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); // config defaut của flutter
  await di.init();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); // set huong cho app
  runApp(App());
}
