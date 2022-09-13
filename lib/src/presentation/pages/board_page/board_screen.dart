import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/src/core/components/app_bar_widget.dart';
import 'package:todo_app/src/core/components/app_button_widget.dart';
import 'package:todo_app/src/core/constants/board_screen_consts.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/core/utils/screen_onresume_task_notification.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/presentation/bloc/bloc.dart';
import 'package:todo_app/src/presentation/widgets/board_page_widgets/widgets.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  void initState() {
    BoardBloc.get(context).add(BoardFetchAllTasks());
    BoardBloc.get(context).add(BoardFetchCompletedTasks());
    BoardBloc.get(context).add(BoardFetchUnCompletedTasks());
    BoardBloc.get(context).add(BoardFetchFavouriteTasks());
    BoardBloc.get(context).add(BoardFetchAllNotifications());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (AppBloc.get(context).appLaunchTask != null) {
        onAppResumeFromTaskNotificationSelect(
          taskScreenRoute,
          context,
        ).then(
          (value) => AppBloc.get(context).add(
            AppUpdateAppLaunchTaskEvent(null),
          ),
        );
      }
    });
    super.initState();
  }

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
              AppUpdateAppLaunchTaskEvent(null),
            ),
          );
        }
      },
      child: BlocConsumer<BoardBloc, BoardState>(
        listener: (context, state) {
          debugPrint('$state');
          switch (state.runtimeType) {
            case BoardLoadingState:
              Get.dialog(
                DialogWidget(
                  message: (state as BoardLoadingState).loadingMessage!,
                  isError: false,
                ),
                barrierDismissible: false,
              );
              break;
            case BoardErrorState:
              Get.dialog(
                DialogWidget(
                  message: (state as BoardErrorState).errMessage,
                  isError: true,
                ),
                barrierDismissible: false,
              );
              break;
            case BoardLoadedState:
              Get.back();
              break;
          }
        },
        builder: (context, state) {
          return DefaultTabController(
            length: tabsText.length,
            child: Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: MyAppBar(
                  text: 'Board',
                  isBoardScreen: true,
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      const BoardTabBar(),
                      Container(
                        width: double.infinity,
                        height: 0.8,
                        color: Colors.grey,
                      ),
                      const BoardTabBarView(),
                      AppButton(
                        text: 'Add a task',
                        onPress: () => Get.toNamed(
                          createTaskScreenRoute,
                        )!
                            .then(
                          (value) {
                            if (value != null) {
                              BoardBloc.get(context).add(
                                BoardUpdateTasksAfterCreate(
                                  task: value as TaskModel,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
