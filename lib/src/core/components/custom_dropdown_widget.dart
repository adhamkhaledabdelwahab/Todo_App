import 'package:flutter/material.dart';
import 'package:todo_app/src/core/constants/task_model_const.dart';

class CustomDropdownWidget extends StatelessWidget {
  const CustomDropdownWidget({
    Key? key,
    required this.dataMap,
    required this.onDropdownChange,
    this.iconData = Icons.keyboard_arrow_down,
    this.iconColor = Colors.grey,
    this.isReminder,
  }) : super(key: key);

  final Map<int, dynamic> dataMap;
  final Function(int? val) onDropdownChange;
  final IconData iconData;
  final Color iconColor;
  final bool? isReminder;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButton<int>(
          items: dataMap.keys
              .map(
                (e) => DropdownMenuItem<int>(
                  value: e,
                  child: Text(
                    isReminder == true
                        ? getReminder(e)
                        : isReminder == false
                            ? getRepeat(e)
                            : dataMap.values.toList()[e],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onDropdownChange,
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          dropdownColor: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
          iconSize: 32,
          elevation: 4,
          underline: Container(
            height: 0,
          ),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
      ],
    );
  }
}
