import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/components/my_button.dart';
import 'package:firebase_project/components/my_textfield.dart';
import 'package:firebase_project/formkey.dart';
import 'package:firebase_project/json_files/info.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

// SignUp Method

  Future signUp() async {
    // FOR AUTHENTICATION
    try {
      if (passwordConfirmed()) {
        //ADD NEW USERS
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      } else {
        matchPasswordmessage();
      }

//ADD USER DETAILS TO DATABASE
      var email = _emailController.text.trim();
      var fname = _fnameController.text.trim();
      var lname = _lnameController.text.trim();
      var age = int.parse(_ageController.text.trim());

      addinfo(fname, lname, email, age);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // for weak password
        weakpasswordmessage();
      } else if (e.code == 'email-already-in-use') {
        //email is already in use
        AlreadyEmailmessage();
      }
    } catch (e) {
      print(e);
    }
  }

  Future addinfo(String _fname, String _lname, String _email, int _age) async {
    var info = Info(fname: _fname, lname: _lname, email: _email, age: _age);
    await FirebaseFirestore.instance.collection('users').add(info.toJson());
  }

// checking if the confirmed password is equal to set password or not
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  void matchPasswordmessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Password Is not matched'),
          );
        });
  }

  void weakpasswordmessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Weak Password'),
          );
        });
  }

  void AlreadyEmailmessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Email is already in use'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.android_sharp,
                    size: 100,
                  ),
                  SizedBox(height: 10),
                  //Hello again
                  Text('HELLO THERE!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      )),
                  SizedBox(height: 20),
                  Text(
                    'Register Below! And Lets Connect!',
                    style: TextStyle(fontSize: 18),
                  ),
                  //email textfield

                  SizedBox(height: 50),
                  MyTextfield(
                      controller: _fnameController,
                      hintText: 'First Name',
                      obscureText: false),
                  //password textfield
                  SizedBox(height: 20),
                  MyTextfield(
                      controller: _lnameController,
                      hintText: 'Last Name',
                      obscureText: false),
                  //password textfield
                  SizedBox(height: 20),
                  MyTextfield(
                      controller: _ageController,
                      hintText: 'Age',
                      obscureText: false),
                  //password textfield
                  SizedBox(height: 20),
                  MyTextfield(

                      validator: (email)=>
                      email!=null&& EmailValidator.validate(email)? null:'Enter a valid Email Address',
                      controller: _emailController,
                      hintText: 'Email',
                      obscureText: false),
                  //password textfield
                  SizedBox(height: 20),
                  MyTextfield(

                      controller: _passwordController,
                      validator: (value){
                        if(value!=null&&value.length<7){
                          return 'Password is less than 7 character';
                        }else{
                          return null;
                        }
                      },
                      hintText: 'Password',
                      obscureText: true),

                  //confirm password

                  SizedBox(
                    height: 20,
                  ),
                  MyTextfield(
                      controller: _confirmpasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true),
                  //sign button

                  SizedBox(height: 25),
                  MyButton(onTap: signUp, text: 'Sign In'),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' I am a Member!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                          onTap: widget.showLoginPage,
                          child: Text(
                            ' LogIn Now',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
