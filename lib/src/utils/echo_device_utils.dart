/// FileName echo_device_utils
///
/// @Author LinGuanYu
/// @Date 2023/3/16 10:50
///
/// @Description TODO

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class EchoDeviceUtils {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);

  static bool get isMobile => isAndroid || isIOS;

  static bool get isMobile2 =>
      defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;

  /// Platform不能在web端使用
  static bool get isWeb => kIsWeb;

  static bool get isWindows => isWeb ? false : Platform.isWindows;

  static bool get isLinux => isWeb ? false : Platform.isLinux;

  static bool get isMacOS => isWeb ? false : Platform.isMacOS;

  static bool get isAndroid => isWeb ? false : Platform.isAndroid;

  static bool get isFuchsia => isWeb ? false : Platform.isFuchsia;

  static bool get isIOS => isWeb ? false : Platform.isIOS;

  static Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  static Future<String> appName() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.appName;
  }

  static Future<String> packageName() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.packageName;
  }

  static Future<String> version() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.version;
  }

  static Future<String> buildNumber() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.buildNumber;
  }

  static Future<String> buildSignature() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.buildSignature;
  }

  static Future<String?> installerStore() async {
    PackageInfo packageInfo = await getPackageInfo();
    return packageInfo.installerStore;
  }


}