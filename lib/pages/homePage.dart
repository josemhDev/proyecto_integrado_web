import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_integrado_3/pages/bottomBarPage.dart';
import 'package:proyecto_integrado_3/pages/loginPage.dart';
import 'package:proyecto_integrado_3/pages/sideBarPage.dart';
import 'package:proyecto_integrado_3/providers/googleSignInProvider.dart';
import 'package:proyecto_integrado_3/providers/storageProvider.dart';
import 'package:proyecto_integrado_3/widgets/listFilesWidget.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.hasData){

            var authProvider = Provider.of<GoogleSignInProvider>(context, listen: false);
            authProvider.provider = FirebaseAuth.instance.currentUser!.providerData[0].providerId;
            
            
              return FutureBuilder(
                future: authProvider.getUserData(),
                
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    return !kIsWeb
                     ? const BottomNavPage()
                     : const SideBarPage();
                  }
                  else{
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              );
            
            //return const BottomNavPage();
      /* FutureBuilder(
      future: storageProvder.getFiles(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, 'home');
          });
        }
        return const Center(child: CircularProgressIndicator(),);
      }),
    ); */
          }
          else{
            return const LoginPage();
          }
        },
      ),
    );
  }
}