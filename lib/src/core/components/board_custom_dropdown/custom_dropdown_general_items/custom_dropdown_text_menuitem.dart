import 'package:flutter/material.dart';

class CustomDropdownTextMenuItem extends StatelessWidget {
  const CustomDropdownTextMenuItem({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      child: Row(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
