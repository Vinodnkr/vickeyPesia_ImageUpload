// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, non_constant_identifier_names, avoid_unnecessary_containers, use_build_context_synchronously

// ignore: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p_1/addList.dart';
import 'package:p_1/pages/about_page.dart';
import 'package:p_1/pages/second_screen.dart';
import 'package:p_1/service/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  Stream? EmployeeStream;
  TextEditingController titleController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  get children => null;

  getontheload() async {
    EmployeeStream = await DatabaseMethods().getListDetails();

    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
        stream: EmployeeStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: ((context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondScreen(
                                        title: ds['Title'],
                                        image: ds['Image'],
                                        description: ds['Description'],
                                        id:ds['Id'],
                                      )),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),

                            // cut
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Title : ' + ds["Title"],
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Image(
                                      image: NetworkImage(ds["Image"]),
                                      width: 100,
                                      height: 100,
                                    ),
                                  ],
                                ),
                                // image display error resolved

                                Row(children: [
                                  GestureDetector(
                                      onTap: () {
                                        titleController.text = ds['Title'];
                                        imageController.text = ds['Image'];
                                        descriptionController.text =
                                            ds['Description'];
                                        EditEmployeeDetails(ds['Id']);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
   
                                  IconButton(
                                    icon: Icon(Icons.delete,
                                        color: Colors.orange),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Icon(Icons.delete,
                                                color: Colors.orange),
                                            content: const Text(
                                                'Are you sure to delete?'),
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
                                                      .DeleteListDetails(
                                                          ds['Id']);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  )

                                 
                                ]),
                              ],
                            ),
                          
                          ),
                        ),
                      ),
                    );
                  }))
              : Container();
        });
  }

  void searchButton() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://flutter-tutorial.net/images/sample_background_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://i.ibb.co/Pz3kcXF/WIN-20240321-11-00-22-Pro.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text('Vinod Kumar', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vicky',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Pedia',
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              )
            ],
          ),
          backgroundColor: Color.fromARGB(255, 132, 244, 190),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const addList()));
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Item'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://d1tgh8fmlzexmh.cloudfront.net/ccbp-dynamic-webapps/wiki-logo-img.png",
              width: 100,
              height: 100,
            ),
        /*    const Text(
              'Search Bar',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    // controller: _searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Search here',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                searchButton();
              },
              child: const Text('Click to Search'),
            ),
            SizedBox(
              height: 20,
          ),
            */  const Text(
              'List Of Article',
              style: TextStyle(
                fontSize: 28,
                color: Colors.orange,
              ),
            ),
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }

// POP UP EDIT AREA
  Future EditEmployeeDetails(String id) => showDialog(
      context: context,
      builder: (content) => AlertDialog(
              content: Container(
                  child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel)),
                  SizedBox(
                    width: 60,
                  ),
                  Text(
                    "Edit ",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Details",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Title',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
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
                height: 30,
              ),
              Text(
                'Image',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
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
                height: 30,
              ),
              Text(
                'Description',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> updateInfo = {
                      "Title": titleController.text,
                      "Image": imageController.text,
                      "Description": descriptionController.text,
                      "Id": id,
                    };
                    await DatabaseMethods()
                        .UpdateListDetails(id, updateInfo)
                        .then((value) {
                      Navigator.pop(content);
                    });
                  },
                  child: Text('Update'))
            ],
          ))));
}
