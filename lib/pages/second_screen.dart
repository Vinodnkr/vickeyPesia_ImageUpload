// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'dart:typed_data';
import 'dart:ui';

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
  _SecondScreenState createState() =>
      _SecondScreenState(titles: title, descriptions: description);
}

class _SecondScreenState extends State<SecondScreen> {
  late String titles;
  late String descriptions;

  _SecondScreenState({required this.titles, required this.descriptions});

  static String imageUrl = '';
  // final String imageUrl = widget.image;
  bool isloading = false;
  bool _isEditing = false;
  bool _isEditingDesc = false;

  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerDesc = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: titles);
    _controllerDesc = TextEditingController(text: descriptions);
  }

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
                      content: const Text('Are you sure to delete?'),
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
                            if (widget.image != null) {
                              try {
                                final storageReference = FirebaseStorage
                                    .instance
                                    .refFromURL(widget.image);
                                await storageReference.delete();
                                print(
                                    'Image successfully deleted from Firebase Storage.');
                              } catch (error) {
                                print('Error deleting image: $error');
                              }
                            }

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
                      child: _isEditing
                          ? TextField(
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: _controller,
                              onChanged: (newValue) {
                                setState(() {
                                  widget.title = newValue;
                                });
                              },
                            )
                          : Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEditing = !_isEditing;
                          if (_isEditing) {
                            _controller.selection = TextSelection.fromPosition(
                                TextPosition(offset: _controller.text.length));
                          }
                        });
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
                      image: NetworkImage(imageUrl == ""
                          ? widget.image == ""
                              ? 'https://i.ibb.co/zNtWCLz/Screenshot-2024-03-30-101745.png'
                              : widget.image
                          : imageUrl),
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
                            String uniqueFileName = widget.id;
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
                                  .putData(
                                      fileBytes!,
                                      SettableMetadata(
                                          contentType: 'image/jpg'))
                                  .whenComplete(() => Fluttertoast.showToast(
                                      msg: "Image Uploaded to Firebase",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 20.0));
                              var imageUr =
                                  await referenceRoot.getDownloadURL();

                              setState(() {
                                isloading = false;
                                imageUrl = imageUr.toString();
                                //  print(imageUrl);
                              });

                              Map<String, dynamic> updateInfo = {
                                "Title": widget.title,
                                "Image":
                                    imageUrl == "" ? widget.image : imageUrl,
                                "Description": widget.description,
                                "Id": widget.id,
                              };
                              await DatabaseMethods()
                                  .UpdateListDetails(widget.id, updateInfo)
                                  .then((value) {});
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
                  
                       _isEditingDesc
                          ? TextField(
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                              controller: _controllerDesc,
                                maxLines:5,

                              onChanged: (newValue) {
                                setState(() {
                                  widget.description = newValue;
                                });
                              },
                            )
                          : Text(
                              widget.description,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                    
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEditingDesc = !_isEditingDesc;
                          if (_isEditingDesc) {
                            _controllerDesc.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _controllerDesc.text.length));
                          }
                        });
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                  /*      InlineEditableText(
                      text: widget.description,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        overflow: TextOverflow.clip,
                      ),
                      onTextChanged: (String value) {
                        widget.description = value;
                      },
                    ),*/
                ),

                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> updateInfo = {
                        "Title": widget.title,
                        "Image": imageUrl == "" ? widget.image : imageUrl,
                        "Description": widget.description,
                        "Id": widget.id,
                      };
                      await DatabaseMethods()
                          .UpdateListDetails(widget.id, updateInfo)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      });

                      imageUrl = '';
                    },
                    child: Text('Update'))

                // // Other widgets go here
              ],
            ),
          ),
        ));
  }
}
