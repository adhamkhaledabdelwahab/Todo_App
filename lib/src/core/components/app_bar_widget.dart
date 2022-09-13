import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_menuitem_container.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_text_menuitem.dart';
import 'package:todo_app/src/core/constants/board_screen_consts.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/presentation/bloc/board_bloc/board_bloc.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    required this.text,
    required this.isBoardScreen,
  }) : super(key: key);

  final String text;
  final bool isBoardScreen;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
      leading: !isBoardScreen
          ? IconButton(
              onPressed: () {
                FocusManager.instance.primaryFocus!.unfocus();
                Future.delayed(
                  const Duration(milliseconds: 100),
                ).then(
                  (value) => Get.back(),
                );
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.black,
              ),
            )
          : null,
      actions: isBoardScreen
          ? [
              BlocBuilder<BoardBloc, BoardState>(
                builder: (context, state) {
                  final unReadNotifications = BoardBloc.get(context)
                      .allNotifications
                      .where((element) => element.isRead == 0)
                      .toList();
                  return Badge(
                    position: BadgePosition.topEnd(end: 0, top: 4),
                    showBadge: unReadNotifications.isNotEmpty,
                    badgeContent: Text('${unReadNotifications.length}'),
                    child: CustomDropDown(
                      onChange: (int value) {},
                      buttonIcon: Icons.notifications_active,
                      isNotification: true,
                    ),
                  );
                },
              ),
              CustomDropDown(
                onChange: (int value) {
                  switch (value) {
                    case 0:
                      BoardBloc.get(context).add(BoardDeleteAllTasks());
                      break;
                    case 1:
                      BoardBloc.get(context)
                          .add(BoardMarkAllTasksAsFavourite());
                      break;
                    case 2:
                      BoardBloc.get(context)
                          .add(BoardMarkAllTasksAsUnFavourite());
                      break;
                    case 3:
                      BoardBloc.get(context)
                          .add(BoardMarkAllTasksAsCompleted());
                      break;
                    case 4:
                      BoardBloc.get(context)
                          .add(BoardMarkAllTasksAsUnCompleted());
                      break;
                  }
                },
                dropMenuItems: boardAppbarActions
                    .map((key, value) {
                      return MapEntry(
                        key,
                        CustomDropDownMenuItemContainer(
                          child: CustomDropdownTextMenuItem(
                            value: value,
                          ),
                        ),
                      );
                    })
                    .values
                    .toList(),
                buttonIcon: Icons.more_vert_outlined,
                isNotification: false,
              ),
              IconButton(
                onPressed: () => Get.toNamed(
                  scheduledTasksScreenRoute,
                ),
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.black,
                ),
              ),
            ]
          : null,
    );
  }
}
