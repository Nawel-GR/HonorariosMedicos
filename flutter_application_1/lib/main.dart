import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:intl/date_symbol_data_file.dart';

void main() async {
  // Ensure that the plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();


  // Locale Date initialization
  await initializeDateFormatting('es_ES', '');

  return runApp(
     const HonorApp(),
    
  );
}

class HonorApp extends StatelessWidget {
  const HonorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kairos',
      theme: HonorTheme.lightTheme,
      routes: honorRoutes,
      home: const LoginScreen() ,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      locale: const Locale('es'),
      supportedLocales: const [Locale('es')],
    
    );
  }
}