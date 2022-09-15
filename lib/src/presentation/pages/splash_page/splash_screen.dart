import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/src/core/components/tasks_view_error_widget.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:todo_app/src/presentation/widgets/splash_page_widgets/splash_body_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    AppBloc.get(context).add(AppInitializeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppInitializedState) {
          Future.delayed(const Duration(seconds: 1)).then(
            (value) => Get.offNamed(
              boardScreenRoute,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: state is AppInitializingErrorState
                  ? TasksViewErrorWidget(errMessage: state.message)
                  : const SplashBodyWidget(),
            ),
          ),
        );
      },
    );
  }
}
