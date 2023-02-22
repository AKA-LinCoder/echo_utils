import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// FileName echo_button
///
/// @Author LinGuanYu
/// @Date 2023/2/22 14:11
///
/// @Description TODO 封装button

class EchoButton extends StatelessWidget {
  final double? height;
  final String buttonName;
  final Color? buttonColor;
  final TextStyle? buttonTextStyle;
  final Function() onPressed;
  const EchoButton({Key? key,this.height, required this.buttonName, this.buttonColor, this.buttonTextStyle, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
                height: height??40,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white),
                  onPressed: onPressed,
                  child: Text(
                    buttonName,
                    style: buttonTextStyle??Styles.headLineStyle4.copyWith(
                        color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
