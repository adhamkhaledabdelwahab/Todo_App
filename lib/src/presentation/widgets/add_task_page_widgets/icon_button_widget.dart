import 'package:flutter/material.dart';

class InputFieldSuffixWidget extends StatelessWidget {
  const InputFieldSuffixWidget({
    Key? key,
    required this.onPress,
    required this.icon,
  }) : super(key: key);

  final Function() onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
    );
  }
}
