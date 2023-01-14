import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/json_files/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Basketpage extends StatefulWidget {
  const Basketpage({Key? key}) : super(key: key);

  @override
  State<Basketpage> createState() => _BasketpageState();
}

class _BasketpageState extends State<Basketpage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Item> basketItems = [];
  String Value = '';

  @override
  void initState() {
    fetchRecords();
    super.initState();
  }

  fetchRecords() async {
    await FirebaseFirestore.instance
        .collection('basket_items')
        .snapshots()
        .listen(
      (records) {
        mapRecords(records);
      },
    );
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map(
          (item) => Item(
            id: item.id,
            name: item['name'],
            quantity: item['quantity'],
          ),
        ).toList();

    setState(() {
      basketItems = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.logout,
              )),
          IconButton(
            onPressed: () {
              showDialogue();
            },
            icon: Icon(Icons.add),
            color: Colors.white,
          )
        ],
      ),
      body: ListView.builder(
          itemCount: basketItems.length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (c) {
                      deleteItem(basketItems[index].id);
                    },
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                    spacing: 8,
                  ),
                ],
              ),
              child: ListTile(
                  title: Text(basketItems[index].name),
                  subtitle: Text(basketItems[index].quantity ?? ''),
                  ),
            );
          }),
    );
  }

  showDialogue() {
    showDialog(
        context: context,
        builder: (context) {
          var nameController = TextEditingController();
          var quantityController = TextEditingController();
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text('Add Item'),


                  TextField(
                    controller: nameController,
                  ),
                  TextField(
                    controller: quantityController,
                  ),
                  TextButton(
                      onPressed: () {
                        var name = nameController.text.trim();
                        var quantity = quantityController.text.trim();

                        additem(name, quantity);
                        Navigator.pop(context);
                      },
                      child: const Text('Add'))
                ],
              ),
            ),
          );
        });
  }

  additem(String name, String quantity) {
    var item = Item(id: 'id', name: name, quantity: quantity);
    FirebaseFirestore.instance.collection('basket_items').add(item.toJson());
  }

  deleteItem(String id) {
    FirebaseFirestore.instance.collection('basket_items').doc(id).delete();
  }
}
