import 'package:mvvmbasic/view/home_screen.dart';

import '../view/splash_screen.dart';

enum AppRoutes{
  splashScreen,
  homeScreen,
}

var routes = {
AppRoutes.splashScreen.name: (context) => const SplashScreen(),
AppRoutes.homeScreen.name: (context) => const HomeScreen(),
};
