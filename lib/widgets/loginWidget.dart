import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/googleSignInProvider.dart';

class LoginWidget extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: kIsWeb ? size.width * 0.7 : double.infinity,
            child: const Text(
              'BIENVENIDO',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  height: 1,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: kIsWeb ? size.width * 0.7 : double.infinity,
            child: const Text(
              'Por favor, inicia sesión para continuar',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: SizedBox(
            width: kIsWeb ? size.width * 0.7 : double.infinity,
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: SizedBox(
            width: kIsWeb ? size.width * 0.7 : double.infinity,
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Contraseña',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SignInButtons(emailController: emailController, passwordController: passwordController, size: size),
        
      ],
    );
  }
}

class SignInButtons extends StatelessWidget {
  const SignInButtons({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.size,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        
        children: [
          GestureDetector(
            onTap: () async {
              var authProvider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              await authProvider.signIn(
                  emailController.text.trim(), passwordController.text.trim());
            },
            child: Container(
              height: 50,
              width: kIsWeb ? size.width * 0.3 : double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0XFF1C1C1C).withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: const Offset(0, 3))
                  ]),
              child: const Center(
                child: Text(
                  'INICIAR SESION',
                  style: TextStyle(
                      fontSize: 24, color: Color.fromARGB(255, 0, 140, 255)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
      SizedBox(
        height: 16,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize:
                  Size(kIsWeb ? size.width * 0.3 : double.infinity, 50)),
          icon: FaIcon(
            FontAwesomeIcons.google,
            color: Colors.red,
          ),
          label: Text('Iniciar sesión con google'),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogin();
          },
        ),
      ),
        ],
      ),
    );
  }
}
