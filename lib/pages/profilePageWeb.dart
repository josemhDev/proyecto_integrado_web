import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_integrado_3/providers/googleSignInProvider.dart';
import 'package:proyecto_integrado_3/providers/storageProvider.dart';
import 'package:email_validator/email_validator.dart';

import '../painters/curvePainter.dart';

class ProfileWebPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ProfileWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var authProvider = Provider.of<GoogleSignInProvider>(context);
    var storageProvider = Provider.of<StorageProvider>(context);
    nameController.text = authProvider.currentuser!.name;
    emailController.text = authProvider.currentuser!.email;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 57, 60, 76),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.25,
              child: CustomPaint(
                painter: CurvePainter(true),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 0),
                ),
              ),
            ),

            Positioned(
                top: size.height * 0.2,
                bottom: size.height * 0.1,
                right: size.width * 0.05,
                left: size.width * 0.05,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 57, 60, 76),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade900,
                            blurRadius: 3,
                            spreadRadius: 3,
                            offset: const Offset(0, 4))
                      ]),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          Column(
                            children: [
                              SizedBox(height: 30),
                              TextField(
                            onSubmitted: (value) {
                              authProvider.updateUserName(value);
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            enabled: authProvider.provider == 'password',
                            onFieldSubmitted: (value) {
                              if(formKey.currentState!.validate()){
                                authProvider.updateUserEmail(value);
                              }
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Introduce un email válido'
                                    : null,
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none),
                                ),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0)),
                          ),

                            ],
                          ),
                          
                          
                          ElevatedButton(onPressed: (() {
                            authProvider.logout();
                          }), 
                          child: const Text('Cerrar sesión'))
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}