import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/components/custom_dropdown_widget.dart';
import 'package:todo_app/src/core/constants/create_task_screen_consts.dart';
import 'package:todo_app/src/core/constants/task_model_const.dart';
import 'package:todo_app/src/presentation/bloc/create_task_bloc/create_task_bloc.dart';
import 'package:todo_app/src/presentation/widgets/add_task_page_widgets/widgets.dart';

class AddTaskForm extends StatelessWidget {
  const AddTaskForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskBloc, CreateTaskState>(
      builder: (context, state) {
        return Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  AddTaskFormInputField(
                    title: "Title",
                    hint: "Task title",
                    errText: state is TaskCreatingErrorState &&
                            state.errMessage == createTaskEmptyTitleErrMsg
                        ? state.errMessage
                        : null,
                    controller: CreateTaskBloc.get(context).titleController,
                  ),
                  AddTaskFormInputField(
                    title: "Description",
                    hint: "Task description",
                    controller:
                        CreateTaskBloc.get(context).descriptionController,
                  ),
                  AddTaskFormInputField(
                    title: "Date",
                    hint: CreateTaskBloc.get(context).selectedDate,
                    widget: InputFieldSuffixWidget(
                      icon: Icons.calendar_today_outlined,
                      onPress: () async {
                        final bloc = CreateTaskBloc.get(context);
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015),
                          lastDate: DateTime(DateTime.now().year + 20),
                        );
                        if (pickedDate != null) {
                          bloc.add(
                            UpdateCreateTask(
                              createTaskUpdate: CreateTaskUpdate.selectedDate,
                              selectedDate: pickedDate,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  AddTaskFormTimeField(
                    onEndTimePress: () async {
                      final bloc = CreateTaskBloc.get(context);
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                          DateTime.now().add(
                            const Duration(minutes: 30),
                          ),
                        ),
                      );

                      if (pickedTime != null) {
                        bloc.add(
                          UpdateCreateTask(
                            createTaskUpdate: CreateTaskUpdate.selectedEndTime,
                            selectedEndTime: pickedTime,
                          ),
                        );
                      }
                    },
                    onStartTimePress: () async {
                      final bloc = CreateTaskBloc.get(context);
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                      );
                      if (pickedTime != null) {
                        bloc.add(
                          UpdateCreateTask(
                            createTaskUpdate:
                                CreateTaskUpdate.selectedStartTime,
                            selectedStartTime: pickedTime,
                          ),
                        );
                      }
                    },
                    endTimeHint: CreateTaskBloc.get(context).selectedEndTime,
                    startTimeHint:
                        CreateTaskBloc.get(context).selectedStartTime,
                  ),
                  AddTaskFormInputField(
                    title: 'Remind',
                    hint: getReminder(
                        CreateTaskBloc.get(context).selectedReminder),
                    widget: CustomDropdownWidget(
                      dataMap: taskReminders,
                      onDropdownChange: (int? val) {
                        if (val != null) {
                          CreateTaskBloc.get(context).add(
                            UpdateCreateTask(
                              createTaskUpdate:
                                  CreateTaskUpdate.selectedReminder,
                              selectedReminder: val,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  AddTaskFormInputField(
                    title: 'Repeat',
                    hint: getRepeat(CreateTaskBloc.get(context).selectedRepeat),
                    widget: CustomDropdownWidget(
                      dataMap: taskRepeats,
                      onDropdownChange: (int? val) {
                        if (val != null) {
                          CreateTaskBloc.get(context).add(
                            UpdateCreateTask(
                              createTaskUpdate: CreateTaskUpdate.selectedRepeat,
                              selectedRepeat: val,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AddTaskFormInputField(
                    title: 'Notification Sound',
                    hint:
                        CreateTaskBloc.get(context).selectedAudioPath.isNotEmpty
                            ? CreateTaskBloc.get(context)
                                .selectedAudioPath
                                .split("/")
                                .last
                            : 'Selected Sound Path',
                    widget: InputFieldSuffixWidget(
                      onPress: () async {
                        final createTask = CreateTaskBloc.get(context);
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(type: FileType.audio);
                        if (result != null) {
                          createTask.add(
                            UpdateCreateTask(
                              createTaskUpdate:
                                  CreateTaskUpdate.selectedAudioPath,
                              selectedAudioPath: result.paths[0],
                            ),
                          );
                        }
                      },
                      icon: Icons.audio_file_outlined,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AddTaskFormColorWidget(
                    onColorSelect: (index) => CreateTaskBloc.get(context).add(
                      UpdateCreateTask(
                        createTaskUpdate: CreateTaskUpdate.selectedColor,
                        selectedColor: index,
                      ),
                    ),
                    selectedIndex: CreateTaskBloc.get(context).selectedColor,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
