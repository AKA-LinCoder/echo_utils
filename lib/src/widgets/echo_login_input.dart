import 'package:flutter/material.dart';

/// FileName echo_login_input
///
/// @Author LinGuanYu
/// @Date 2023/3/21 16:28
///
/// @Description TODO 登陆页面使用的按钮

class EchoLoginInput extends StatefulWidget {
  final String? hitText;
  final InputBorder? inputBorder;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? iconColor;
  final bool? isPassword;
  const EchoLoginInput({Key? key,this.hitText,
    this.inputBorder,this.controller,this.prefixIcon,
    this.suffixIcon,this.iconColor,this.isPassword}) : super(key: key);

  @override
  State<EchoLoginInput> createState() => _EchoLoginInputState();
}

class _EchoLoginInputState extends State<EchoLoginInput> {

  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword==true?!passwordVisible:false,
      decoration: InputDecoration(
        ///默认边框
        enabledBorder: widget.inputBorder?? const UnderlineInputBorder(
          /*边角*/
          // borderRadius: BorderRadius.all(
          //   Radius.circular(30), //边角为30
          // ),
          borderSide: BorderSide(
            color: Colors.grey, //边线颜色为黄色
            width: 1, //边线宽度为2
          ),
        ),
        iconColor: widget.iconColor??Colors.grey,
        prefixIcon: widget.prefixIcon??const Icon(
          Icons.alternate_email_outlined,
          color: Colors.grey,
        ),
        suffixIcon: widget.isPassword==true?widget.suffixIcon??IconButton(onPressed: (){
          passwordVisible = !passwordVisible;
          setState(() {

          });
        }, icon:  Icon(
          passwordVisible?Icons.visibility_outlined:Icons.visibility_off_outlined,
          color: Colors.grey,
        )):null,
        hintText: widget.hitText??"email",
      ),
    );
  }
}
