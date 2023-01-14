import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/components/my_button.dart';
import 'package:firebase_project/components/my_textfield.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future ResetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Reset Link is Sent! Please check your Email '),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Enter Your Email To Get the Reset Password Link',
              style: TextStyle(
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          MyTextfield(controller: _emailController, hintText: 'Email',obscureText: false),
          SizedBox(height: 25),
          MyButton(onTap: ResetPassword, text: 'Reset Password')
        ],
      ),
    );
  }
}
