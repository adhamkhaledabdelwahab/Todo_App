import 'package:flutter/material.dart';

class CustomDropDownMenuItemContainer extends StatelessWidget {
  final Widget child;

  const CustomDropDownMenuItemContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
