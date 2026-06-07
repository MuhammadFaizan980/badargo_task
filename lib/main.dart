import 'package:badargo_task/data/app_base_model.dart';
import 'package:badargo_task/router/app_routes.dart';
import 'package:badargo_task/router/app_routes_generator.dart';
import 'package:badargo_task/utils/app_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';

import 'app_di.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
final AppThemeColors appThemeColors = AppThemeColors();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDi.initDi();

  runApp(
    ViewModelBuilder.reactive(
      viewModelBuilder: () => GetIt.I.get<AppBaseModel>(),
      builder: (context, vm, _) => Sizer(
        builder: (context, orientation, screenType) {
          return MainApp();
        },
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: generateRoutes,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: appThemeColors.colorPrimary,
          onPrimary: appThemeColors.onPrimary,
          secondary: appThemeColors.colorSecondary,
          onSecondary: appThemeColors.onSecondary,
        ),
      ),
      initialRoute: AppRoutes.splashScreen,
    );
  }
}
