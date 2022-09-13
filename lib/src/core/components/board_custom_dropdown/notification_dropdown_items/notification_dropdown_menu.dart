import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_menuitem_container.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_text_menuitem.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/notification_dropdown_items/notification_dropdown_menu_item.dart';
import 'package:todo_app/src/core/components/empty_list_view.dart';
import 'package:todo_app/src/core/components/tasks_view_error_widget.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/presentation/bloc/board_bloc/board_bloc.dart';

class NotificationListView extends StatelessWidget {
  const NotificationListView({
    Key? key,
    required this.scrollController,
    required this.dropMenuBackgroundColor,
    required this.onTap,
  }) : super(key: key);

  final ScrollController scrollController;
  final Color dropMenuBackgroundColor;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BoardBloc, BoardState>(
      listener: (context, state) {
        debugPrint('$state');
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    color: Colors.black87,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tasks Notifications",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      CustomDropDown(
                        onChange: (int value) {
                          if (BoardBloc.get(context)
                              .allNotifications
                              .isNotEmpty) {
                            BoardBloc.get(context).add(
                              BoardMarkAllNotificationsAsRead(),
                            );
                          }
                        },
                        dropMenuItems: {
                          0: 'Mark All As Read',
                        }
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
                        iconColor: Colors.white,
                        dropMenuBackgroundColor: Colors.teal,
                        isNotification: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 1,
                )
              ],
            ),
            Expanded(
              child: state is BoardErrorState
                  ? TasksViewErrorWidget(
                      errMessage: (state).errMessage,
                    )
                  : BoardBloc.get(context).allNotifications.isNotEmpty &&
                          BoardBloc.get(context).allTasks.isNotEmpty
                      ? Scrollbar(
                          controller: scrollController,
                          interactive: true,
                          radius: const Radius.circular(10),
                          thickness: 8,
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              controller: scrollController,
                              itemCount: BoardBloc.get(context)
                                  .allNotifications
                                  .length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    Material(
                                      borderRadius: index ==
                                              BoardBloc.get(context)
                                                      .allNotifications
                                                      .length -
                                                  1
                                          ? const BorderRadius.vertical(
                                              bottom: Radius.circular(10),
                                            )
                                          : null,
                                      clipBehavior: Clip.hardEdge,
                                      color: BoardBloc.get(context)
                                                  .allNotifications[index]
                                                  .isRead ==
                                              1
                                          ? dropMenuBackgroundColor
                                          : Colors.grey.shade800,
                                      child: InkWell(
                                        onTap: () async {
                                          final board = BoardBloc.get(context);
                                          await onTap(index);
                                          if (board.allNotifications[index]
                                                  .isRead ==
                                              0) {
                                            board.add(
                                              BoardMarkSingleNotificationAsRead(
                                                notification: board
                                                    .allNotifications[index],
                                              ),
                                            );
                                          }
                                          Get.toNamed(
                                            taskScreenRouteFromBoard,
                                            arguments:
                                                board.allTasks.firstWhere(
                                              (element) =>
                                                  element.uniqueName ==
                                                  board.allNotifications[index]
                                                      .taskUniqueName,
                                            ),
                                          );
                                        },
                                        child:
                                            NotificationDropdownMenuItemWidget(
                                          markNotificationAsRead:
                                              (notification) {
                                            BoardBloc.get(context).add(
                                              BoardMarkSingleNotificationAsRead(
                                                notification: notification,
                                              ),
                                            );
                                          },
                                          notificationModel:
                                              BoardBloc.get(context)
                                                  .allNotifications[index],
                                          taskModel: BoardBloc.get(context)
                                              .allTasks
                                              .firstWhere((element) =>
                                                  element.uniqueName ==
                                                  BoardBloc.get(context)
                                                      .allNotifications[index]
                                                      .taskUniqueName),
                                        ),
                                      ),
                                    ),
                                    index !=
                                            BoardBloc.get(context)
                                                    .allNotifications
                                                    .length -
                                                1
                                        ? Container(
                                            color: Colors.grey,
                                            height: 1,
                                          )
                                        : Container(),
                                  ],
                                );
                              }),
                        )
                      : const EmptyListView(
                          textColor: Colors.white,
                          notifications: true,
                        ),
            ),
          ],
        );
      },
    );
  }
}
