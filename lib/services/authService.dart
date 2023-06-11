import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_integrado_3/utils/utils.dart';

class authService {

  Future signUp(String email, String password) async{

    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    
  }


  Future signIn(String email, String password) async{

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e){
      print(e);
    }
  }
}