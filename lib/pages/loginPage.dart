import 'package:flutter/material.dart';
import 'package:proyecto_integrado_3/widgets/loginOption.dart';
import 'package:proyecto_integrado_3/widgets/registerOptionWidget.dart';
import 'package:proyecto_integrado_3/widgets/registerWidget.dart';

import '../painters/curvePainter.dart';
import '../widgets/loginWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool login = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? size.height * 0.6 : size.height * 0.4,
                child: CustomPaint(
                  painter: CurvePainter(login),
                  child: Container(
                    padding: EdgeInsets.only(bottom: login ? 0 : 55),
            
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: login
                            ? LoginWidget()
                            : GestureDetector(
                              onTap: () => setState(() => login = true),
                              child: const LoginOption()
                              )
                        ),
                      ),
                    ),
                  ),
                ),
            
              ),
            

            SizedBox(
                height: login ? size.height * 0.4 : size.height * 0.6,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: !login
                          ? RegisterWidget()
                          : GestureDetector(
                            onTap: () => setState(() => login = false),
                            child: const RegisterOprionWidget()
                            )
                      ),
                    ),
                  ),
                ),
            
              ),
           ],
        ),
      )
    );
  }
}
