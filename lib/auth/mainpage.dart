import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/auth/LoginPage.dart';
import 'package:firebase_project/auth/auth_page.dart';
import 'package:firebase_project/pages/basket_page.dart';

import 'package:firebase_project/auth/home.dart';
import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For signin step 1
    return  Scaffold(

      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
          if(snapshot.hasData){
            return MyHomePage();
          }else{
            return AuthPage();
          }
          },
      ),
    );
  }
}
