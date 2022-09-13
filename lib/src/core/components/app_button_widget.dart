import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, required this.text, required this.onPress})
      : super(key: key);

  final String text;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: HexColor("#25C06D"),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPress,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
