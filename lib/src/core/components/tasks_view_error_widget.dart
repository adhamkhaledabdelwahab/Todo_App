import 'package:flutter/material.dart';

class TasksViewErrorWidget extends StatelessWidget {
  const TasksViewErrorWidget({Key? key, required this.errMessage})
      : super(key: key);

  final String errMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/todo_error.png',
            height: 250,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            errMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
