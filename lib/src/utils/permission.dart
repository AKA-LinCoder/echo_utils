/// FileName permission
///
/// @Author LinGuanYu
/// @Date 2023/2/25 14:34
///
/// @Description TODO 权限申请

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class EchoPermissionUtil {
  final BuildContext _context;

  EchoPermissionUtil(this._context);

  //在检查之前可以去申请权限
  void checkPermission(PermissionStatus status, Permission permission,String name) async {
    if (status.isDenied) {
      //拒绝了权限
      showPermissionRequestDialog('您拒绝了申请$name权限，但是该应用需要$name权限，是否授权', permission, true,name);
    } else if (status.isPermanentlyDenied) {
      //永久拒绝了权限 提示用户
      showPermissionRequestDialog('您永久拒绝了$name权限，但是该应用需要$name权限，是否授权', permission, true,name);
    } else {
      //通过权限申请
    }
  }

  void showPermissionRequestDialog(String message, Permission permission, bool gotoAppSettings,String name) {
    showDialog(context: _context,
        builder: (context) {
          return AlertDialog(
            title: const Text('权限申请'),
            content: SizedBox(width: 200, child: Text(message),),
            actions: <Widget>[
              MaterialButton(onPressed: () async{
                Navigator.of(context).pop();
                await closeApp();
                // Navigator.of(context).pop();
              }, child: const Text('拒绝')),
              MaterialButton(onPressed: () {
                Navigator.of(context).pop();
                if (gotoAppSettings){
                  openAppSettings() ;
                }else {
                  requestPermission(context, permission,name);
                }
              }, child: const Text('确定')),
            ],
            actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          );
        });
  }

  Future<PermissionStatus> requestPermission(BuildContext context, Permission permission,String name) async{
    ///请求权限
    ///Map<Permission, PermissionStatus> statuses = await [
    ///  Permission.photosAddOnly,
    ///   Permission.photos
    /// ].request(); //同时请求多个全新啊
    PermissionStatus status = await permission.request();
    checkPermission(status, permission,name);
    return status;
  }

  /// 关闭应用
  Future closeApp()async{
    exit(0);
  }

}