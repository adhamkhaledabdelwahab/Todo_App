import 'package:flutter/material.dart';

class AddTaskFormInputField extends StatelessWidget {
  const AddTaskFormInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.errText})
      : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final String? errText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: false,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            readOnly: widget != null ? true : false,
            cursorColor: Colors.grey[700],
            decoration: InputDecoration(
              errorText: errText,
              errorStyle: const TextStyle(fontSize: 17),
              suffixIcon: widget,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 18,
              ),
              fillColor: Colors.grey.shade300,
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
