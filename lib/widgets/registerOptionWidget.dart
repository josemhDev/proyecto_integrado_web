import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisterOprionWidget extends StatelessWidget {
  const RegisterOprionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('¿No tienes una cuenta?'),
        const SizedBox(height: 16),
        Container(
            height: 50,
            width: kIsWeb ?size.width * 0.3 : double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 140, 255),
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
                'REGISTRATE',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            
          )
        
      ],
    );
  }
}