import 'package:flutter/material.dart';
import 'package:todo_app/src/core/constants/board_screen_consts.dart';

class BoardTabBar extends StatelessWidget {
  const BoardTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 3,
      indicatorColor: Colors.black,
      isScrollable: true,
      labelColor: Colors.black,
      labelStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      labelPadding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 5,
        bottom: 5,
      ),
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      tabs: List.generate(
        tabsText.length,
        (index) => Tab(
          text: tabsText[index],
        ),
      ),
    );
  }
}
