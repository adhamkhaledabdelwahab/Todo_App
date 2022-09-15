import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/src/core/components/app_bar_widget.dart';
import 'package:todo_app/src/core/components/app_button_widget.dart';
import 'package:todo_app/src/core/constants/create_task_screen_consts.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/core/utils/screen_onresume_task_notification.dart';
import 'package:todo_app/src/injection_container.dart';
import 'package:todo_app/src/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:todo_app/src/presentation/bloc/create_task_bloc/create_task_bloc.dart';
import 'package:todo_app/src/presentation/widgets/add_task_page_widgets/widgets.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (AppBloc.get(context).appLaunchTask != null) {
          onAppResumeFromTaskNotificationSelect(
            taskScreenRoute,
            context,
          ).then(
            (value) => AppBloc.get(context).add(
              AppUpdateSelectedTaskNotificationEvent(null),
            ),
          );
        }
      },
      child: BlocProvider<CreateTaskBloc>(
        create: (context) => serviceLocator<CreateTaskBloc>()
          ..add(
            InitializeCreateTask(),
          ),
        child: BlocListener<CreateTaskBloc, CreateTaskState>(
          listener: (context, state) {
            debugPrint('$state');
            if (state is TaskCreatedState) {
              Get.back(result: state.task);
            } else if (state is TaskCreatingErrorState &&
                state.errMessage != createTaskEmptyTitleErrMsg) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Get.showSnackbar(
                GetSnackBar(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.white54,
                  messageText: Text(
                    state.errMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
          },
          child: Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: MyAppBar(
                text: "Add Task",
                isBoardScreen: false,
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    const AddTaskForm(),
                    BlocBuilder<CreateTaskBloc, CreateTaskState>(
                      builder: (context, state) {
                        return AppButton(
                          text: "Create a task",
                          onPress: () async {
                            FocusManager.instance.primaryFocus!.unfocus();
                            CreateTaskBloc.get(context).add(CreateTask());
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
