import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/googleSignInProvider.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          Spacer(),
          FlutterLogo(size: 120,),
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Hey There,\nWelcome Back',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 8,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Login to your accout to continue',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Spacer(),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50)
            ),
            icon: FaIcon(Icons.mail_outline, color: Colors.white,),
            label: Text('Sign Up with Email'),
            onPressed: () {

              
              
            },
          ),
          SizedBox(height: 15,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: Size(double.infinity, 50)
            ),
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.red,),
            label: Text('Sign Up with Google'),
            onPressed: () {

              final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
              provider.googleLogin();
              
            },
          ),
          
          SizedBox(height: 40,),
          RichText(
            text: TextSpan(
              text: 'Already have an account?',
              children: [
                TextSpan(
                  text: ' Log in',
                  style: TextStyle(decoration:  TextDecoration.underline)
                )
              ]
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}