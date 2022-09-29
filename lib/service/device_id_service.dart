import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:platform_device_id_platform_interface/platform_device_id_platform_interface.dart';
import 'package:flutter/material.dart';

class DeviceIdService {
  DeviceIdService._internal();

  static final DeviceIdService _instance = DeviceIdService._internal();

  factory DeviceIdService() {
    return _instance;
  }

  var deviceValue = '';

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future getDeviceId() async {
    String? deviceId;
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.androidId;
        deviceValue = deviceId;
        debugPrint(deviceValue);
        return deviceId;
      } else {
        deviceId = await PlatformDeviceIdPlatform.instance.getDeviceId();
      }
    } on PlatformException {
      deviceId = '';
    }
    debugPrint("DS DeviceId $deviceValue");
    debugPrint("DS DeviceId $deviceId");

    return deviceValue;
  }
}
