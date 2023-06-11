import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
        const Text('¿Ya tienes una cuenta?'),
        const SizedBox(height: 16),
        Container(
            height: 50,
            width: kIsWeb ?size.width * 0.3 : double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0XFF1C1C1C).withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: const Offset(0,3)
                )
              ]
            ),
            child:const Center(
              child: Text(
                'INICIAR SESION',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 0, 140, 255)
                ),
              ),
            ),
            
          )
        
      ],
    );
  }
}