import 'package:firebase_project/formkey.dart';
import 'package:flutter/material.dart';
class MyTextfield extends StatelessWidget {
  final controller;
  final hintText;
  final obscureText;
  final  validator;

  const MyTextfield({Key? key,required this.controller, required this.hintText, this.obscureText, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(

        obscureText: obscureText,
        validator:validator,
        controller: controller,
        decoration: InputDecoration(

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white),

          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: hintText,

          fillColor: Colors.grey[200],
          filled: true,

        ),
      ),
    );
  }
}
