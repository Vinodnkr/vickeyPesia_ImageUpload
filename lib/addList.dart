// ignore_for_file: camel_case_types, prefer_const_constructors

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p_1/service/database.dart';
import 'package:random_string/random_string.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class addList extends StatefulWidget {
  const addList({super.key});

  @override
  State<addList> createState() => _addListState();
}

class _addListState extends State<addList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // ignore: constant_identifier_names
  String Id = randomAlphaNumeric(10);
  // ignore: constant_identifier_names, non_constant_identifier_names
  //static const String Id=id;

  String imageUrl = '';
  bool isloading = false;
  // XFile? image;

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
            Image.network(
              imageUrl == ''
                  ? "https://i.ibb.co/zNtWCLz/Screenshot-2024-03-30-101745.png"
                  : imageUrl,
              width: 330,
              height: 330,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  //   getImage();
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.image);
                  if (result != null) {
                    setState(() {
                      isloading = true;
                    });
                    // Unique file name
                    // String uniqueFileName =
                    //     DateTime.now().millisecondsSinceEpoch.toString();
                    Uint8List? fileBytes = result.files.first.bytes;
                    //String fileName = result.files.first.name;

                    try {
                      Reference referenceRoot =
                          FirebaseStorage.instance.ref('images/$Id');

                      await referenceRoot
                          .putData(fileBytes!,
                              SettableMetadata(contentType: 'image/jpg'))
                          .whenComplete(() => Fluttertoast.showToast(
                              msg: "Image Uploaded to Firebase",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 20.0));
                      setState(() {
                        isloading = false;
                      });
                      var imageUr = await referenceRoot.getDownloadURL();
                      //print(imageUrl);
                      setState(() {
                        imageUrl = imageUr;
                      });

                      //  print(imageUrl);
                    } catch (e) {
                      // print(e);
                    }
                  }
                },
                icon: Icon(Icons.image),
                label: Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            if (isloading)
              SpinKitThreeBounce(
                color: Colors.black,
                size: 20,
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

                    Map<String, dynamic> listInfoMap = {
                      "Id": Id,
                      "Title": titleController.text,
                      "Image": imageUrl,
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
                      descriptionController.clear();
                      //imageUrl='';
                    });
                    setState(() {
                      imageUrl = '';
                    });
                    //Navigator.pop(context);
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
