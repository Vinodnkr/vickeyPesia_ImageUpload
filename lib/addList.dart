// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p_1/service/database.dart';
import 'package:random_string/random_string.dart';

class addList extends StatefulWidget {
  const addList({super.key});

  @override
  State<addList> createState() => _addListState();
}

class _addListState extends State<addList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              ' List',
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            //  Text('   Add List', style: TextStyle(color: Colors.black),)
          ],
        ),
        backgroundColor: Color.fromARGB(255, 132, 244, 190),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Text(
              'Image',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: imageController,
                maxLines: 2,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 20,
            ),


            Text(
              'Description',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: descriptionController,
                maxLines: 10,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),

            
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    // ignore: non_constant_identifier_names
                    String Id = randomAlphaNumeric(10);
                    Map<String, dynamic> listInfoMap = {
                      "Id": Id,
                      "Title": titleController.text,
                      "Image": imageController.text,
                      "Description": descriptionController.text,
                    };
                    await DatabaseMethods()
                        .addListDetails(listInfoMap, Id)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg:
                              "Title, Image, Description has been added successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 20.0);
                      titleController.clear();
                      imageController.clear();
                      descriptionController.clear();
                    });
                  },
                  child: Text('Add',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
            )
          ],
        ),
      ),
    );
  }
}
