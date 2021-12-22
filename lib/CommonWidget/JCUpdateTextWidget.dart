// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, overridden_fields

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class JCUpdateTextWidget extends StatefulWidget {
  @override
  final Key? key;
  late TextStyle style;

  // 接收一个Key
  JCUpdateTextWidget(this.key, {TextStyle? style}) {
    this.style = style ??
        TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500);
  }

  @override
  State<StatefulWidget> createState() => JCUpdateTextWidgetState();
}

class JCUpdateTextWidgetState extends State<JCUpdateTextWidget> {
  String _text = "0%";

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500),
    );
  }

  void updateText(String? textString) {
    setState(() => _text = textString ?? "");
  }
}
