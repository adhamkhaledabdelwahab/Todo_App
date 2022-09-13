import 'package:flutter/material.dart';
import 'package:todo_app/src/presentation/widgets/splash_page_widgets/splash_text_widget.dart';

class SplashBodyWidget extends StatelessWidget {
  const SplashBodyWidget({Key? key}) : super(key: key);

  final String _splashImagePath = "assets/images/splash_background.png";

  final double _splashScreenPadding = 30;

  final double _splashImageHeight = 300;

  final String _splashTitleText = "Manage and prioritize you tasks easily";

  final double _titleFontSize = 30;

  final FontWeight _titleFontWeight = FontWeight.bold;

  final Color _titleColor = Colors.black;

  final String _splashAppInfoText =
      "Increase your productivity by managing your personal "
      "and team task and do them based on the highest priority!";

  final double _subtitleFontSize = 18;

  final FontWeight _subtitleFontWeight = FontWeight.w500;

  final Color _subtitleColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          _splashImagePath,
          fit: BoxFit.cover,
          height: _splashImageHeight,
        ),
        Padding(
          padding: EdgeInsets.all(_splashScreenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SplashTextWidget(
                fontWeight: _titleFontWeight,
                color: _titleColor,
                text: _splashTitleText,
                fontSize: _titleFontSize,
              ),
              const SizedBox(
                height: 30,
              ),
              SplashTextWidget(
                fontWeight: _subtitleFontWeight,
                color: _subtitleColor,
                text: _splashAppInfoText,
                fontSize: _subtitleFontSize,
              ),
            ],
          ),
        )
      ],
    );
  }
}
