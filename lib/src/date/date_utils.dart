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

///@title formatTimeStringRange
///@description 格式化时间段
///@param: startTimeStr
///@param: endTimeStr
///@return: String
///@updateTime 2023/11/28 17:16
///@author LinGuanYu
String formatTimeStringRange(String startTimeStr, String endTimeStr) {

  DateTime startTime = DateTime.parse(startTimeStr);
  DateTime endTime = DateTime.parse(endTimeStr);

  if (startTime.year == endTime.year &&
      startTime.month == endTime.month &&
      startTime.day == endTime.day) {
    // 开始时间和结束时间在同一天
    return '${startTime.year}-${_formatNumber(startTime.month)}-${_formatNumber(startTime.day)} '
        '${_formatTime(startTime)}-${_formatTime(endTime)}';
  } else {
    // 开始时间和结束时间不在同一天
    return '${startTime.year}-${_formatNumber(startTime.month)}-${_formatNumber(startTime.day)} '
        '${_formatTime(startTime)}-${endTime.year}-${_formatNumber(endTime.month)}-${_formatNumber(endTime.day)} '
        '${_formatTime(endTime)}';
  }
}

String _formatNumber(int number) {
  // 格式化数字，保证是两位数，如 1 变为 '01'
  return number.toString().padLeft(2, '0');
}

String _formatTime(DateTime time) {
  // 格式化时间，如 8:30 变为 '08:30'
  return '${_formatNumber(time.hour)}:${_formatNumber(time.minute)}';
}