// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login.dart';

// 🌎 Project imports:

Map<String, Widget Function(BuildContext)> honorRoutes = <String, WidgetBuilder>{
  // route: /login
  LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
};
