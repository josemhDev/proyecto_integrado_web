import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_integrado_3/firebase_options.dart';
import 'package:proyecto_integrado_3/pages/fileInfoPage.dart';
import 'package:proyecto_integrado_3/pages/homePage.dart';
import 'package:proyecto_integrado_3/pages/profilePage.dart';
import 'package:proyecto_integrado_3/pages/uploadFilePage.dart';
import 'package:proyecto_integrado_3/providers/appProvider.dart';

import 'package:proyecto_integrado_3/providers/googleSignInProvider.dart';
import 'package:proyecto_integrado_3/providers/storageProvider.dart';
import 'package:proyecto_integrado_3/utils/utils.dart';
import 'package:proyecto_integrado_3/widgets/listFilesWidget.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb;


Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    }
  else{
    await Firebase.initializeApp();

  }

  runApp(const MyApp());
  
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var utils = Utils();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => AppProvider())),
        ChangeNotifierProvider(create: ((context) => GoogleSignInProvider())),
        ChangeNotifierProvider(create: ((context) => StorageProvider()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Material App',
          scaffoldMessengerKey: utils.messengerKey,
          home: const HomePage(),
          theme: ThemeData.dark(), /* ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.muktaVaaniTextTheme()
          ) */
          routes: {
            "upload":(context) => const UploadFilePage(),
            "info":(context) => FileInfoPage(),
            "home":(context) => const ListFilesWidget(),
            "login":(context) => const HomePage(),
            "profile":(context) => ProfilePage(),
          }
        ),
    );
    
  }
}