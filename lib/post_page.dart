import 'dart:convert';

import 'package:firebase_project/Models/PostModels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  List<PostModels> postList=[];

  Future<List<PostModels>> getpostApi() async{

    final response= await http.put(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        postList.add(PostModels.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Posts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getpostApi(),
                builder: (context,snapshot){

if()



            },),
          )
        ],
      ),
    );
  }
}
