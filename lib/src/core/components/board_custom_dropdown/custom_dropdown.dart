// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_menuitem_container.dart';
import 'package:todo_app/src/core/components/board_custom_dropdown/custom_dropdown_general_items/custom_dropdown_overlay.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    Key? key,
    required this.onChange,
    required this.buttonIcon,
    required this.isNotification,
    this.iconColor = Colors.black,
    this.dropMenuBackgroundColor = Colors.black87,
    this.onMenuItemsScrollAtEdge,
    this.iconSize = 25,
    this.dropMenuItems,
  }) : super(key: key);

  final bool isNotification;
  final IconData buttonIcon;
  final Function(int index) onChange;
  final Color iconColor;
  final Color dropMenuBackgroundColor;
  final double iconSize;
  final Function()? onMenuItemsScrollAtEdge;
  final List<CustomDropDownMenuItemContainer>? dropMenuItems;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown>
    with SingleTickerProviderStateMixin {
  late GlobalKey _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late Size buttonSize;
  late OverlayEntry _overlayEntry;
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _scaleTransitionAnimation;

  @override
  void initState() {
    _key = LabeledGlobalKey("button_icon");
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleTransitionAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox? renderBox =
        _key.currentContext!.findRenderObject() as RenderBox?;
    buttonSize = renderBox!.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  Future<void> closeMenu() async {
    await _animationController.reverse();
    _overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context)!.insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: _key,
      padding: EdgeInsets.zero,
      iconSize: widget.iconSize,
      color: widget.iconColor,
      icon: Icon(widget.buttonIcon),
      onPressed: () {
        if (isMenuOpen) {
          closeMenu();
        } else {
          openMenu();
        }
      },
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return CustomOverlayWidget(
          dropMenuItems: widget.dropMenuItems,
          closeMenu: closeMenu,
          scaleTransitionAnimation: _scaleTransitionAnimation,
          buttonPosition: buttonPosition,
          buttonSize: buttonSize,
          dropMenuBackgroundColor: widget.dropMenuBackgroundColor,
          isNotification: widget.isNotification,
          onChange: widget.onChange,
          scrollController: _scrollController,
        );
      },
    );
  }
}
