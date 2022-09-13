import 'package:flutter/material.dart';
import 'package:todo_app/src/presentation/widgets/add_task_page_widgets/widgets.dart';

class AddTaskFormTimeField extends StatelessWidget {
  const AddTaskFormTimeField({
    Key? key,
    required this.onStartTimePress,
    required this.onEndTimePress,
    required this.startTimeHint,
    required this.endTimeHint,
  }) : super(key: key);

  final Function() onStartTimePress;
  final Function() onEndTimePress;
  final String startTimeHint;
  final String endTimeHint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: AddTaskFormInputField(
            hint: startTimeHint,
            title: 'Start Time',
            widget: InputFieldSuffixWidget(
              icon: Icons.access_time_rounded,
              onPress: onStartTimePress,
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 1,
          child: AddTaskFormInputField(
            hint: endTimeHint,
            title: 'End time',
            widget: InputFieldSuffixWidget(
              icon: Icons.access_time_rounded,
              onPress: onEndTimePress,
            ),
          ),
        ),
      ],
    );
  }
}
