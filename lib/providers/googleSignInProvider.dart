import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyecto_integrado_3/model/User.dart';
import 'package:proyecto_integrado_3/services/authService.dart';
import 'package:proyecto_integrado_3/services/fireStoreService.dart';

class GoogleSignInProvider extends ChangeNotifier {
  
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user;
  String provider = '';
  UserModel? currentuser;

  Future googleLogin() async {
    
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;
      user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);

      
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future signIn (String email, String password) async{

    var as = authService();
    await as.signIn(email, password);
    
  }

  Future signUp(String email, String password) async {
    var as = authService();

    await as.signUp(email, password);
  }

  Future getUserData() async{
    var fs = FirestoreService();
    currentuser = await fs.getUser();
  }

  Future createUser(String name, String email) async{
    var fs = FirestoreService();
    await fs.createUser(UserModel(email: email, name: name, imgProfilePath: ''));
  }

  Future updateUserName(String newValue) async{

  final fs = FirestoreService();
  try{

    await fs.updateUserName(newValue);
    currentuser!.name = newValue;

    notifyListeners();

  
  }catch(e){
    print(e);
  }
  
}


Future updateUserEmail(String newValue) async{

  final fs = FirestoreService();
  try{

    await fs.updateUserEmail(newValue);
    currentuser!.email = newValue;

    notifyListeners();

  
  }catch(e){
    print(e);
  }
  
}


  Future logout() async {

    if(provider == 'google.com'){
      
    }

    FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    
  }
}
