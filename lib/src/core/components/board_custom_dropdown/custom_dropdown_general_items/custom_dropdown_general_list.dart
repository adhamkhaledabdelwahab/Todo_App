import 'package:flutter/material.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_menuitem_container.dart';

class GeneralListView extends StatelessWidget {
  const GeneralListView(
      {Key? key,
      required this.scrollController,
      required this.dropMenuBackgroundColor,
      required this.onTap,
      required this.dropMenuItems})
      : super(key: key);

  final ScrollController scrollController;
  final Color dropMenuBackgroundColor;
  final Function(int index) onTap;
  final List<CustomDropDownMenuItemContainer> dropMenuItems;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      interactive: true,
      radius: const Radius.circular(10),
      thickness: 8,
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          controller: scrollController,
          itemCount: dropMenuItems.length,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                Material(
                  borderRadius: index == 0
                      ? const BorderRadius.vertical(
                          top: Radius.circular(10),
                        )
                      : index == dropMenuItems.length - 1
                          ? const BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            )
                          : null,
                  clipBehavior: Clip.hardEdge,
                  color: dropMenuBackgroundColor,
                  child: InkWell(
                    onTap: () => onTap(index),
                    child: dropMenuItems[index].child,
                  ),
                ),
                index != dropMenuItems.length - 1
                    ? Container(
                        color: Colors.grey,
                        height: 1,
                      )
                    : Container(),
              ],
            );
          }),
    );
  }
}
