import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/auth_gate.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/routes/routes.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:intl/date_symbol_data_local.dart';


void main() async {
  // Ensure that the plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  // Locale Date initialization
  await initializeDateFormatting('es_ES', null);

  return runApp(
     const HonorApp(),
    
  );
}

class HonorApp extends StatelessWidget {
  const HonorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Kairos',
      theme: HonorTheme.lightTheme,
      //routes: honorRoutes,
      home: AuthGate() ,
      //builder: BotToastInit(),
      //navigatorObservers: [BotToastNavigatorObserver()],
      //locale: const Locale('es'),
      //supportedLocales: const [Locale('es')],
      //localizationsDelegates: const [
      //  GlobalMaterialLocalizations.delegate,
      //  GlobalCupertinoLocalizations.delegate,

      //],
    );
  }
}