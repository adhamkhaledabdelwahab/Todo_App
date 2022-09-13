import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'device_info.dart';
import 'notification_event.dart';

typedef EventCallbackFunc = void Function(NotificationEvent? evt);

class NotificationServicePlugin {
  static final _instance = NotificationServicePlugin._constructor();

  static NotificationServicePlugin get instance => _instance;

  final MethodChannel _onNotificationChannel = const MethodChannel(
      "notifications_listener_service/RUN_DART_BACKGROUND_METHOD");
  final MethodChannel _runNativeBackgroundChannel = const MethodChannel(
      "notifications_listener_service/RUN_NATIVE_BACKGROUND_METHOD");
  final MethodChannel _runNativeForegroundChannel = const MethodChannel(
      "notifications_listener_service/RUN_NATIVE_FOREGROUND_METHOD");
  final String _permissionGrantedMethod = "isNotificationPermissionGranted";
  final String _requestPermissionMethod = "requestNotificationPermission";
  final String _getDeviceInfoMethod = "getDeviceInfo";
  final String _channelNameExistsMethod = "isExist";

  NotificationServicePlugin._constructor();

  static void _printError(String text) {
    debugPrint('\x1B[31m$text\x1B[0m');
  }

  Future<MethodChannel> _testWhichChannel() async {
    try {
      await _runNativeForegroundChannel.invokeMethod(_channelNameExistsMethod);
      return _runNativeForegroundChannel;
    } catch (e) {
      return _runNativeBackgroundChannel;
    }
  }

  Future<bool> _isPermissionGranted() async {
    return await (await _testWhichChannel())
        .invokeMethod(_permissionGrantedMethod) as bool;
  }

  Future<bool> isServicePermissionGranted() async {
    try {
      return await _isPermissionGranted();
    } catch (e) {
      _printError(
        "Fetching Notifications Listener Service Permission State Error: $e",
      );
      return false;
    }
  }

  Future<void> _requestPermission() async {
    return await (await _testWhichChannel())
        .invokeMethod(_requestPermissionMethod);
  }

  Future<void> requestServicePermission() async {
    try {
      return await _requestPermission();
    } catch (e) {
      _printError(
        "Requesting Notifications Listener Service Permission Error: $e",
      );
    }
  }

  Future<void> requestPermissionsIfDenied() async {
    final permissionGranted = await isServicePermissionGranted();
    if (!permissionGranted) {
      await requestServicePermission();
    }
  }

  Future _getDeviceInfo() async {
    return await (await _testWhichChannel()).invokeMethod(_getDeviceInfoMethod);
  }

  Future<DeviceInfo?> getDeviceInfo() async {
    try {
      final result = await _getDeviceInfo();
      return DeviceInfo.newEvent(result);
    } catch (e) {
      _printError("Fetching Device Info Error: $e");
    }
    return null;
  }

  void registerCallBackHandler(EventCallbackFunc callback) {
    try {
      _onNotificationChannel.setMethodCallHandler((call) {
        final result = _registerCallBackHandler(callback, call);
        return Future.value(result);
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> initialize(EventCallbackFunc callbackHandler) async {
    CallbackHandle? callbackTest =
        PluginUtilities.getCallbackHandle(callbackHandler);
    if (callbackTest == null) {
      throw Exception(
          "The callbackDispatcher needs to be either a static function or a top level function to be accessible as a Flutter entry point.");
    }
    registerCallBackHandler(callbackHandler);
    await requestPermissionsIfDenied();
  }

  bool _registerCallBackHandler(EventCallbackFunc callback, MethodCall call) {
    try {
      NotificationEvent evt = NotificationEvent.newEvent(call.arguments);
      callback(evt);
      return true;
    } catch (e) {
      _printError('Registering CallBack Handler Error: $e');
      return false;
    }
  }
}
