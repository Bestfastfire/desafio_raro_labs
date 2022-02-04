import 'package:desafio_raro_labs/tools/widget_tools.dart';
import 'package:get/get.dart';

class OverlayControl{
  final _overlayState = false.obs;
  final _overlayMessage = ''.obs;

  static String get currentMessage => _instance!._overlayMessage.value;
  static bool get currentState => _instance!._overlayState.value;
  String get message => _instance!._overlayMessage.value;
  bool get state => _instance!._overlayState.value;

  static OverlayControl? _instance;
  factory OverlayControl() {
    _instance ??= OverlayControl._internal();
    return _instance!;
  }

  OverlayControl._internal();

  OverlayControl.inside();

  static set setMessage(String message) =>
      _instance!._overlayMessage.value = message;

  set setMessageInside(String message) =>
      _overlayMessage.value = message;

  static set mergeMessage(String message) =>
      _instance!._overlayMessage.value = _instance!._overlayMessage.value + message;

  set mergeMessageInside(String message) =>
      _overlayMessage.value = _overlayMessage.value + message;

  static set setState(bool state) =>
      _instance!._overlayState.value = state;

  set setStateInside(bool state) =>
      _overlayState.value = state;

  static show({String message = ''}) {
    WidgetTools.removeFocus();

    WidgetTools.doSafetyWhileBuild(() async{
      _instance!._overlayState.value = true;
      _instance!._overlayMessage.value = message;
    });
  }

  showInside({String message = ''}) {
    WidgetTools.removeFocus();

    WidgetTools.doSafetyWhileBuild(() async{
      _overlayState.value = true;
      _overlayMessage.value = message;
    });
  }

  static Future<T> showWhile<T>(Function fun, [String message = '']) async{
    await show(message: message);

    final T res = await fun();
    await hide();

    return res;
  }

  Future<T> showWhileInside<T>(Function fun, [String message = '']) async{
    showInside(message: message);

    final T res = await fun();
    hideInside();

    return res;
  }

  static hide() {
    WidgetTools.doSafetyWhileBuild(() async{
      _instance!._overlayState.value = false;
      _instance!._overlayMessage.value = '';
    });
  }

  hideInside() {
    WidgetTools.doSafetyWhileBuild(() async{
      _overlayState.value = false;
      _overlayMessage.value = '';
    });
  }
}
