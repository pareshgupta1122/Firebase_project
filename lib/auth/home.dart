import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/pages/Read_data.dart';
import 'package:firebase_project/pages/basket_page.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //this one line for getting the email of the current user
  final user = FirebaseAuth.instance.currentUser!;

  //Second method to get users add from data base:
//list to store the ids
  List<String> docsId = [];

  //This is to get the docids from the database and add to the list
  Future docIds() async {
    await FirebaseFirestore.instance.collection('users').orderBy('age',descending: false).get().then((
        snapshot) =>
        snapshot.docs.forEach((documents) {
          docsId.add(documents.reference.id);
        }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(user.email!),
      ),
      body: SingleChildScrollView(
        child: Column(


          children: <Widget>[

            FutureBuilder(
              future: docIds(),
                builder: (context,snapshots) {

                  return ListView.builder(

physics: NeverScrollableScrollPhysics(),


                      shrinkWrap: true,

                      itemCount: docsId.length,

                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(

                            title: GetUserName(documentId: docsId[index],)
                            ,
                            tileColor: Colors.deepPurple[200],

                          ),
                        );
                      }
                  );

                }),
            Text('Signed In As ' + user.email!),
            TextButton(onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Basketpage()));
            },


                child: Text(
                    'Basket Page'
                )),


            TextButton(onPressed: () {
              FirebaseAuth.instance.signOut();
            }, child: Text(
                'Sign Out'
            )),
          ],
        ),
      ),

    );
  }
}

