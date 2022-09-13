import 'package:flutter/material.dart';

class SplashTextWidget extends StatelessWidget {
  const SplashTextWidget(
      {Key? key,
      required this.text,
      required this.color,
      required this.fontSize,
      required this.fontWeight})
      : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
