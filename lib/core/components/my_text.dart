import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText(this.data, {Key? key, this.style}) : super(key: key);

  final String data;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(data, style: style);
  }
}
