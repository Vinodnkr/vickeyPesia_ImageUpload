// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:p_1/pages/home_screen.dart';
import 'package:p_1/pages/inLineEdit.dart';
import 'package:p_1/service/database.dart';

class SecondScreen extends StatefulWidget {
  late  String title;
  late  String image;
  late  String description;
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
  TextEditingController titleController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
                        text: widget
                            .title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ), onTextChanged: (String value) { widget.title=value; }, 
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
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
                      image: NetworkImage(widget.image),
                      width: 600,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10, 
                      child: Icon(
                        Icons.edit, 
                        color: Colors
                            .orange, 
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Description:',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    
    SizedBox(height: 8),
    InlineEditableText(
      text: widget.description,
      style: TextStyle(

        fontSize: 18,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.clip,
      ), onTextChanged: (String value) {widget.description=value; }, 
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
                      "Image": widget.image,
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
