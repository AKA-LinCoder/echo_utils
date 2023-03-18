/// FileName echo_bottom_sheet
///
/// @Author LinGuanYu
/// @Date 2023/2/23 10:00
///
/// @Description TODO 底部弹出选择列表
import 'package:flutter/material.dart';


void echoBottomSheet(BuildContext context, List<BottomSheetModel> items) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items.map((item) {
              return GestureDetector(
                onTap: ()async{
                  Navigator.of(context).pop();
                  item.onPressed(context);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  decoration: item.decoration ??
                      BoxDecoration(
                        color: item.itemBackGroundColor ?? Colors.white,
                      ),
                  height: item.itemHeight ?? 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      item.preWidget??Container(),
                      if(item.preWidget!=null)
                        const SizedBox(width: 10,),
                      Text(
                        item.title,
                        style: item.textStyle ??
                            TextStyle(
                                fontSize: 15,
                                color: item.itemTextColor ?? Colors.black),
                      ),
                      if(item.suffixWidget!=null)
                        const SizedBox(width: 10,),
                      item.suffixWidget??Container(),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      });
}

class BottomSheetModel {
  ///文字
  final String title;

  ///点击事件
  final Function(BuildContext context) onPressed;

  ///文字样式
  final TextStyle? textStyle;

  ///单个item高度
  final double? itemHeight;

  ///单个item布局
  final Decoration? decoration;

  ///单个item背景颜色
  final Color? itemBackGroundColor;

  ///单个文本颜色
  final Color? itemTextColor;
  ///文本前置widget
  final Widget? preWidget;
  ///文本后置widget
  final Widget? suffixWidget;
  BottomSheetModel(
      {required this.title,
      required this.onPressed,
      this.textStyle,
      this.itemHeight,
      this.decoration,
      this.itemBackGroundColor,
      this.itemTextColor,
      this.preWidget,
      this.suffixWidget});
}
