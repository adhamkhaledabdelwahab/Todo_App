import 'package:flutter/material.dart';

class DateListItem extends StatelessWidget {
  const DateListItem(
      {Key? key,
      required this.month,
      required this.day,
      required this.isSelected,
      required this.weekDay,
      required this.onTap,
      this.selectedKey})
      : super(key: key);

  final String month;
  final int day;
  final String weekDay;
  final bool isSelected;
  final Function() onTap;
  final GlobalKey? selectedKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: selectedKey,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(right: 10),
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              month,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
            Text(
              '$day',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
            Text(
              weekDay,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
