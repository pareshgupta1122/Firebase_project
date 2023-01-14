import 'package:email_validator/email_validator.dart';
import 'package:firebase_project/components/my_button.dart';
import 'package:firebase_project/components/my_textfield.dart';
import 'package:firebase_project/components/square.dart';
import 'package:firebase_project/pages/forget_pw_page.dart';
import 'package:firebase_project/auth/google_sign_in.dart';
import 'package:firebase_project/formkey.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  // For Register ontap

  final VoidCallback showRegisterPage;

  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //for the email and passwords

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //signin
  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (_emailController.text == null && _passwordController.text == null) {
        wrongPasswordmessage();
        Navigator.pop(context);
      }

      if (e.code == 'user-not-found') {
        Navigator.pop(context);
        wrongEmailmessage();
        //where User is not found
      } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        //when password is wrong
        wrongPasswordmessage();
      }
    }
  }

  void wrongEmailmessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Wrong Email'),
          );
        });
  }

  void wrongPasswordmessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Wrong Password'),
          );
        });
  }

//dispose
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: SingleChildScrollView(
            child:
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                  Icons.android_sharp,
                  size: 100,
              ),

              SizedBox(height: 20),
              Text(
                  'Welcome Back, You Were Missed!',
                  style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              //email textfield

              SizedBox(height: 50),
              MyTextfield(

                    controller: _emailController,
                    hintText: 'Email',
                    validator: (email)=>
                    email!=null&& EmailValidator.validate(email)? null:'Enter a valid Email Address',


                    obscureText: false),
              //password textfield
              SizedBox(height: 20),
              MyTextfield(

                    validator: (value){
                      if(value!=null&&value.length<7){
                        return 'Password is less than 7 character';
                      }else{
                        return null;
                      }
                    },

                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true),

              // fORGET PASSWORD BUTTON
              SizedBox(
                  height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ForgetPasswordPage();
                            }));
                          },
                          child: Text('Forget Password ?',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
              ),
              //sign button

              SizedBox(height: 25),
              MyButton(onTap:() {

                  final isvalidate=formKey.currentState!.validate();
                  if(isvalidate){
                    signIn();
                  }
              },


                    text: 'Sign In'),

              SizedBox(height: 50),

              Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    )),
                    Text('Or continue with'),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    )),
                  ],
              ),

              SizedBox(height: 25),
              GestureDetector(
                    onTap:()=> AuthService().signInWithGoogle(),
                    child:
              SquareTile(imagePath: 'lib/images/google.png')
              ),
              SizedBox(height: 25),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a Member ?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          ' Register Now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        )),
                  ],
              ),
            ]),
                ),
          )),
    ));
  }
}
