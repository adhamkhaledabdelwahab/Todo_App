import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    Key? key,
    required this.message,
    required this.isError,
  }) : super(key: key);

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          isError
              ? const Icon(
                  Icons.warning,
                  size: 30,
                  color: Colors.red,
                )
              : const CircularProgressIndicator(),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          isError == true
              ? TextButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Close',
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
