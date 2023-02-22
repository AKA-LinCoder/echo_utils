import 'package:flutter/material.dart';
/// FileName echo_search_text_field
///
/// @Author LinGuanYu
/// @Date 2023/2/22 11:16
///
/// @Description TODO 搜索框样式的文本框


class EchoSearchTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged? onSearch;
  final Widget? prefixIcon;
  const EchoSearchTextField({Key? key, this.hintText,this.controller, this.onSearch, this.prefixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (v){
          if(onSearch !=null){
            onSearch!(v);
          }
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.only(left: 40.0, right: 5),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white),
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          hintText: hintText??'Search',
          hintStyle: const TextStyle(color: Colors.white, fontSize: 14)
      ),
    );
  }
}
