import 'package:flutter/material.dart';

class TaskFieldInfo extends StatelessWidget {
  const TaskFieldInfo(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.iconData})
      : super(key: key);

  final String title;
  final String subtitle;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              iconData,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
