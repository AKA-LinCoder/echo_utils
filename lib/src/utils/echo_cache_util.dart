import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// FileName echo_cache_util
///
/// @Author LinGuanYu
/// @Date 2023/3/21 18:35
///
/// @Description TODO

class EchoCacheUtil {
  ///@title total
  ///@description TODO  获取缓存总大小
  ///@updateTime 2023/3/21 18:29
  ///@author LinGuanYu
  static Future<double> total()async{
    var temDir = await getTemporaryDirectory();
    if(!temDir.existsSync()) return 0;
    double total = await _reduce(temDir);
    return total;
  }

  ///@title clear
  ///@description TODO  清除缓存
  ///@return: Future<void>
  ///@updateTime 2023/3/21 18:32
  ///@author LinGuanYu
  static Future<void> clear() async {

    Directory tempDir = await getTemporaryDirectory();
    if (!tempDir.existsSync()) return;
    await _delete(tempDir);
  }

  ///@title _reduce
  ///@description TODO 递归缓存目录，计算缓存大小
  ///@param: file
  ///@return: Future<int>
  ///@updateTime 2023/3/21 18:32
  ///@author LinGuanYu
  static Future<double> _reduce(final FileSystemEntity file) async {
    /// 如果是一个文件，则直接返回文件大小
    if (file is File) {
      double length = double.tryParse((await file.length()).toString())??0;
      return length;
    }

    /// 如果是目录，则遍历目录并累计大小
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();

      double total = 0;

      if (children.isNotEmpty){
        for (final FileSystemEntity child in children) {
          total += await _reduce(child);
        }
      }

      return total;
    }

    return 0;
  }
  ///@title _delete
  ///@description TODO 递归删除缓存目录和文件
  ///@param: file
  ///@return: Future<void>
  ///@updateTime 2023/3/21 18:33
  ///@author LinGuanYu
  static Future<void> _delete(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await _delete(child);
      }
    } else {
      await file.delete();
    }
  }

}