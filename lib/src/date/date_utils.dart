import 'package:intl/intl.dart';

/// FileName date_utils
///
/// @Author LinGuanYu
/// @Date 2023/3/16 09:28
///
/// @Description TODO

///@title getNowDateTimeStr
///@description TODO 获取当前时间格式化字符串
///@param: dateFormat
///@return: String
///@updateTime 2023/3/16 09:31
String getNowDateTimeStr({String? dateFormat}) {
  return DateFormat(dateFormat??"yyyy-MM-dd HH:mm:ss").format(DateTime.now());
}

///@title getDateTimeByFormat
///@description TODO 获取对应时间字符串的时间格式
///@param: dateFormat
///@param: dateTime
///@return: DateTime
///@updateTime 2023/3/16 09:32
DateTime getDateTimeByFormat({String? dateFormat, String? dateTime}) {
  final dtFormat = DateFormat(dateFormat ?? 'yyyy-MM-dd HH:mm:ss');
  return dtFormat.parse(dateTime ?? "12/05/2020");
}
///@title getDateTimeStrByFormat
///@description TODO 获取对应时间字符串的时间格式字符串
///@param: dateFormat
///@param: dateTime
///@return: String
///@updateTime 2023/3/16 09:34
String getDateTimeStrByFormat({String? dateFormat, String? dateTime}) {

  var test = "2021-09-01T00:00:00.000+00:00";
  final dtFormat = DateFormat(dateFormat ?? 'yyyy-MM-dd HH:mm:ss');
  DateTime dateTime1 = DateTime.parse(dateTime ?? test);
  return dtFormat.format(dateTime1);
}