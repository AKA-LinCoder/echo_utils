import 'package:flutter/foundation.dart';

import '../date/date_utils.dart';
import 'common.dart';

/// FileName echo_log
///
/// @Author LinGuanYu
/// @Date 2023/3/16 09:17
///
/// @Description TODO 自定义print

void echoLog(Object message, {Object? error,StackTrace? stackTrace}) {
  if(isRelease){
    return;
  }
  if(error==null&&stackTrace==null){
    //普通日志打印
    if (kDebugMode) {
      print("${getNowDateTimeStr()} 💚DEBUG-> $message");
    }
    return;
  }
  MYCustomTrace programInfo = MYCustomTrace(stackTrace);
  if (kDebugMode) {
    print("--------$message-----------");
  }
  if(error!=null) {
    if (kDebugMode) {
      print("错误信息🆘  $error  🆘");
    }
  }
  if(stackTrace!=null) {
    if (kDebugMode) {
      print("快速前往错误位置👉 ${programInfo.location}:${programInfo.lineNumber} 👈");
      print("文件: ${programInfo.fileName}, 行: ${programInfo.lineNumber}, 错误信息: $error");
    }
  }
  if (kDebugMode) {
    print("--------$message-----------");
  }
}

class MYCustomTrace {
  final StackTrace? _trace;
  String fileName = "";
  String location = "";
  int lineNumber = 0;
  int columnNumber = 0;

  MYCustomTrace(this._trace) {
    if(_trace!=null){
      _parseTrace();
    }

  }

  void _parseTrace() {
    var traceString = _trace.toString().split("\n")[0];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    var listOfInfo = fileInfo.split(":");
    fileName = listOfInfo[0];
    lineNumber = int.parse(listOfInfo[1]);
    var columnStr = listOfInfo[2];
    columnStr = columnStr.replaceFirst(")", "");
    columnNumber = int.parse(columnStr);

    var index = traceString.indexOf("(");
    var lastIndex = traceString.indexOf(".dart");
    var path = traceString.substring(index+1,lastIndex+5);
    location = path;
  }

}