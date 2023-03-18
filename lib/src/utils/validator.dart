/// FileName validator
///
/// @Author LinGuanYu
/// @Date 2023/2/25 14:00
///
/// @Description TODO 检查字符串是否某个规范


/// 检查强密码
bool echoCheckIsStrongPass(String? input){
  if (input == null || input.isEmpty) return false;
  String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~+-=?]).{8,}$';
  return RegExp(pattern).hasMatch(input);
}

/// 检查两个字符串是否相等
bool echoCheckIsSameInput(String firstInput,String secondInput){
  return firstInput!=secondInput;
}

/// 检查邮箱格式
bool echoCheckIsEmail(String? input) {
  if (input == null || input.isEmpty) return false;
  // 邮箱正则
  String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
  return RegExp(regexEmail).hasMatch(input);
}

/// 检查字符长度
bool echoCheckStringLength(String? input, int length) {
  if (input == null || input.isEmpty) return false;
  return input.length >= length;
}
