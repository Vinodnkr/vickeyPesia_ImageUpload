// ignore_for_file: camel_case_types, prefer_const_constructors

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p_1/service/database.dart';
import 'package:random_string/random_string.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:file_picker/file_picker.dart';

class addList extends StatefulWidget {
  const addList({super.key});

  @override
  State<addList> createState() => _addListState();
}

class _addListState extends State<addList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String imageUrl = '';
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
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: IconButton(
                icon: Icon(
                  Icons.upload,
                  size: 30.0,
                ),
                color: Colors.orange,
                onPressed: () async {



                  //   getImage();
FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
if (result != null) {
  // Unique file name
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
   Uint8List? fileBytes = result.files.first.bytes;
 String fileName = result.files.first.name;
//  print(result);
  print(fileName);
  // Upload to Firebase and get reference
  // Reference referenceRoot = FirebaseStorage.instance.ref();
  // Reference referenceDirImages = referenceRoot.child('images/');
  // Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
     try {
         Reference referenceRoot = FirebaseStorage.instance.ref('images/$uniqueFileName.jpg');
          //Reference referenceDirImages = referenceRoot.child('images/');
           //Reference referenceImageToUpload = referenceRoot.child(uniqueFileName);
      // FirebaseStorage.instance.ref('images/$uniqueFileName+$fileName').putData(fileBytes!);
      await referenceRoot.putData(fileBytes!);
       imageUrl = await referenceRoot.getDownloadURL();
       print('Stored in Firebase');
       Fluttertoast.showToast(
                          msg:
                              " Image uploaded successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 20.0);
        imageUrl = await referenceRoot.getDownloadURL();
        print(imageUrl);
     } catch (e) {
       print(e);
     }
      
}

  // // Store the file in Firebase
  // try {
  //   await referenceImageToUpload.putFile(File(path!));
  //   print('Stored in Firebase');

  //   // Get download URL
  //   imageUrl = await referenceImageToUpload.getDownloadURL();
  // } catch (e) {
  //   // Handle any errors
  //   print(e);
  // }


                },
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
