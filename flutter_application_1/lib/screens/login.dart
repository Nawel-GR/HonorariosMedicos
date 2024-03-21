// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:flutter_app/utils/input_utils.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:iconsax/iconsax.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   

    Future<void> login() async {
      if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
        //TODO: Show error
      } else {
        // TODO: Spinner
        try {
         //TODO: login, store preferences and navigate to home
        } catch (e) {
          if (e is TimeoutException) {
            if (context.mounted) {
              //TODO: show timeout error
            }
          } else {
            if (context.mounted) {
             //TODO: show error
            }
          }
        }
        
      }
    }


    // --------- Right side (login form) --------- //
    Widget loginForm() {
      return Container(
        width:  MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(  MediaQuery.of(context).size.width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------- Title --------- //
            Text(
              '¡Bienvenido a Honor!',
              style: HonorTypography.display,
            ),
            const SizedBox(height: 16),
            // --------- Username --------- //
            Container(
              padding: EdgeInsets.all(20),
              color: HonorTheme.colors.primaryVariant,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: HonorTheme.shadows.shadowLarge),
                    child: TextFormField(
                      controller: usernameController,
                      keyboardType: TextInputType.name,
                      decoration: InputUtils.getDecoration(
                        hintText: 'Ingrese su usuario/Correo',
                        prefixIcon: Icon(Iconsax.user, size: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // --------- Password --------- //
                  Container(
                    decoration: BoxDecoration(boxShadow: HonorTheme.shadows.shadowLarge),
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputUtils.getDecoration(
                        hintText: 'Ingrese su contraseña',
                        prefixIcon: Icon(Iconsax.lock, size: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // --------- Login button --------- //
                  Row(
                    children: [
                      HonorButton(
                        bgColor: HonorTheme.colors.primaryVariant,
                        textColor: HonorTheme.colors.dark,
                        buttonSize: ButtonSize.large,
                        text: 'Registrarse',
                        onTap: null,
                      ),
                      HonorButton(
                        buttonSize: ButtonSize.large,
                        text: 'Iniciar sesión',
                        onTap: () => login(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 45),
            
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: 
             Row(
                children: [ loginForm()],
              ),
      ),
    );
  }
}
