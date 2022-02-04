import 'package:flutter/material.dart';

class WidgetTools{
  static Future doSafetyWhileBuild(Future Function() fun) async =>
      await Future.delayed(Duration.zero, () async => await fun());

  static removeFocus() =>
      FocusManager.instance.primaryFocus?.unfocus();
}