import 'package:flutter/material.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/arrow_clipper.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_general_list.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_menuitem_container.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/notification_dropdown_items/notification_dropdown_menu.dart';

class CustomOverlayWidget extends StatelessWidget {
  const CustomOverlayWidget({
    Key? key,
    required this.closeMenu,
    required this.scaleTransitionAnimation,
    required this.buttonPosition,
    required this.buttonSize,
    required this.dropMenuBackgroundColor,
    required this.isNotification,
    required this.onChange,
    this.dropMenuItems,
    required this.scrollController,
  }) : super(key: key);

  final Function closeMenu;
  final Animation<double> scaleTransitionAnimation;
  final Offset buttonPosition;
  final Size buttonSize;
  final Color dropMenuBackgroundColor;
  final bool isNotification;
  final Function(int index) onChange;
  final List<CustomDropDownMenuItemContainer>? dropMenuItems;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => closeMenu(),
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          alignment: Alignment.bottomCenter,
          scale: scaleTransitionAnimation,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: buttonPosition.dy + buttonSize.height - 25,
                left: buttonPosition.dx,
                width: buttonSize.width,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ClipPath(
                    clipper: ArrowClipper(),
                    child: Container(
                      width: 25,
                      height: 25,
                      color: dropMenuBackgroundColor,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: buttonPosition.dy + buttonSize.height,
                left: MediaQuery.of(context).size.width * 0.05,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 30,
                    maxHeight: MediaQuery.of(context).size.height * 0.75,
                  ),
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: dropMenuBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: isNotification
                      ? NotificationListView(
                          scrollController: scrollController,
                          dropMenuBackgroundColor: dropMenuBackgroundColor,
                          onTap: (index) async {
                            await closeMenu();
                          },
                        )
                      : GeneralListView(
                          scrollController: scrollController,
                          dropMenuBackgroundColor: dropMenuBackgroundColor,
                          onTap: (index) async {
                            await closeMenu();
                            onChange(index);
                          },
                          dropMenuItems: dropMenuItems!,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
