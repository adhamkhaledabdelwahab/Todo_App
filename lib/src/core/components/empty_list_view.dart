import 'package:flutter/material.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({
    Key? key,
    this.textColor = Colors.black,
    this.notifications = false,
  }) : super(key: key);

  final Color textColor;
  final bool notifications;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_background.png',
              height: 230,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'No ${notifications ? 'notifications' : 'tasks'} yet, start add and manage your thoughts now',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
