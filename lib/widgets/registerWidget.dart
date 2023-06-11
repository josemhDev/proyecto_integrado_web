import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_integrado_3/providers/googleSignInProvider.dart';
import 'package:proyecto_integrado_3/utils/utils.dart';

class RegisterWidget extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
          child: SizedBox(
            width: kIsWeb ? size.width * 0.7 : double.infinity,
            child: const Text(
              'REGISTRATE',
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
          const SizedBox(
            height: 16,
          ),
          Center(
            child: SizedBox(
              width: kIsWeb ? size.width * 0.7 : double.infinity,
              child: TextFormField(
                controller: nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (name) => name == null 
                    ? 'Debes rellenar este campo'
                    : null,
                
                decoration: InputDecoration(
                    hintText: 'Nombre',
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
          const SizedBox(height: 16,),
          Center(
            child: SizedBox(
              width: kIsWeb ? size.width * 0.7 : double.infinity,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Introduce un email válido'
                        : null,
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
              child: TextFormField(
                controller: passController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (pass) =>
                    pass != null && pass.length < 6 ? 'Mínimo 6 caracteres' : null,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Contraseña',
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
              child: TextFormField(
                controller: confirmPassController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (pass) => pass != null && pass != passController.text
                    ? 'La contraseña no coincide'
                    : null,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Repite la contraseña',
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
          GestureDetector(
            onTap: () async {
              final isValid = formKey.currentState!.validate();
              if (!isValid) return;
              try {
                final authProvider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);

              await authProvider.signUp(
                  emailController.text.trim(), passController.text.trim());
              await authProvider.createUser(nameController.text, emailController.text.trim());   

              } on FirebaseAuthException catch (e) {
           
                 ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Este correo ya está en uso por otra cuenta')));
              }
            },
            child: Center(
              child: Container(
                height: 50,
                width: kIsWeb ? size.width * 0.3 : double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 140, 255),
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
                    'REGISTRARSE',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
