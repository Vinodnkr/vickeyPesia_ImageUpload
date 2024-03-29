// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p_1/pages/home_screen.dart';
import 'package:p_1/pages/inLineEdit.dart';
import 'package:p_1/service/database.dart';

class SecondScreen extends StatefulWidget {
  late String title;
  late String image;
  late String description;
  final String id;

  SecondScreen(
      {super.key,
      required this.title,
      required this.id,
      required this.image,
      required this.description});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}



class _SecondScreenState extends State<SecondScreen> {

  static String imageUrl = '';
 // final String imageUrl = widget.image;
  bool isloading = false;
 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail View"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete, color: Colors.orange),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Icon(Icons.delete, color: Colors.orange),
                      content: const Text('Are you sure you want to delete?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () async {
                            await DatabaseMethods()
                                .DeleteListDetails(widget.id);
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                                msg: "Deleted",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 20.0);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InlineEditableText(
                        text: widget.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        onTextChanged: (String value) {
                          widget.title = value;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Stack(
                  children: <Widget>[
                    Image(
                      image: NetworkImage(imageUrl==""? widget.image:imageUrl),
                      width: 600,
                      height: 600,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          
                          //   getImage();
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(type: FileType.image);
                          if (result != null) {
                            setState(() {
                            isloading = true;
                          });
                            // Unique file name
                            String uniqueFileName=widget.id;
                            // String uniqueFileName = DateTime.now()
                            //     .millisecondsSinceEpoch
                            //     .toString();
                            Uint8List? fileBytes = result.files.first.bytes;
                           // String fileName = result.files.first.name;

                            try {
                              Reference referenceRoot = FirebaseStorage.instance
                                  .ref('images/$uniqueFileName');
                                  print(widget.id);
                                 // print(widget.Id);

                              await referenceRoot
                                  .putData(fileBytes!, SettableMetadata(contentType: 'image/jpg'))
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
                               setState(() async {
                               imageUrl = await referenceRoot.getDownloadURL();
                              // print(imageUrl);

                              });

                              Map<String, dynamic> updateInfo = {
                        "Title": widget.title,
                        "Image": imageUrl=="" ? widget.title:imageUrl,
                        "Description": widget.description,
                        "Id": widget.id,
                      };
                      await DatabaseMethods()
                          .UpdateListDetails(widget.id, updateInfo)
                          .then((value) {
                      });
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
                  ],
                ),
                SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    InlineEditableText(
                      text: widget.description,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.clip,
                      ),
                      onTextChanged: (String value) {
                        widget.description = value;
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> updateInfo = {
                        "Title": widget.title,
                        "Image": imageUrl=="" ? widget.title:imageUrl,
                        "Description": widget.description,
                        "Id": widget.id,
                      };
                      await DatabaseMethods()
                          .UpdateListDetails(widget.id, updateInfo)
                          .then((value) {
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Update'))

                // // Other widgets go here
              ],
            ),
          ),
        ));
  }
}
