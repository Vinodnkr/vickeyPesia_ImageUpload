/*




                  //   getImage();
FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
if (result != null) {
  // Unique file name
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
   Uint8List? fileBytes = result.files.first.bytes;
 String fileName = result.files.first.name;
//  print(result);
//  print(fileName);
  // Upload to Firebase and get reference
  // Reference referenceRoot = FirebaseStorage.instance.ref();
  // Reference referenceDirImages = referenceRoot.child('images/');
  // Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
     await FirebaseStorage.instance.ref('images/$uniqueFileName+$fileName').putData(fileBytes!);
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




  onPressed: () async {
                  //   getImage();
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.image);
                  if (result != null) {
                    // Unique file name
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    Uint8List? fileBytes = result.files.first.bytes;
                    String fileName = result.files.first.name;
                    print(fileName);
                    // Upload to Firebase and get reference
                    // Reference referenceRoot = FirebaseStorage.instance.ref();
                    // Reference referenceDirImages = referenceRoot.child('images/');
                    // Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
                    try {
                      Reference referenceRoot = FirebaseStorage.instance
                          .ref('images/$uniqueFileName.jpg');
                      //Reference referenceDirImages = referenceRoot.child('images/');
                      //Reference referenceImageToUpload = referenceRoot.child(uniqueFileName);
                      // FirebaseStorage.instance.ref('images/$uniqueFileName+$fileName').putData(fileBytes!);
                      await referenceRoot.putData(fileBytes!);
                      var imageUrl = await referenceRoot.getDownloadURL();
                      print('Stored in Firebase');
                      Fluttertoast.showToast(
                          msg: "Image uploaded successfully",
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
                 },




                 


//edit and delete in main page

/*
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
  */     



Australia, the smallest continent, is known for its rich biodiversity and iconic landmarks like the Sydney Opera House and the Great Barrier Reef. It’s a nation of contrasts, from vibrant cities to the vast Outback, and is home to a plethora of unique wildlife and cultural heritage.


Russia, the world’s largest nation, spans Eastern Europe and Northern Asia. Known for its rich history, cultural heritage, and vast natural resources, it plays a pivotal role in global affairs. Post-Soviet Russia faces challenges like economic reforms and geopolitical tensions.

The United Arab Emirates (UAE), a captivating nation on the southeastern tip of the Arabian Peninsula, is a blend of modernity and tradition. With Dubai and Abu Dhabi as its glittering gems, the UAE boasts iconic landmarks like the Burj Khalifa, Sheikh Zayed Mosque, and the Palm Jumeirah. Its golden deserts, bustling souks and rich heritage make it an unforgettable destination for travelers.

Singapore, a vibrant city-state, thrives at the Malay Peninsula’s tip. A bustling metropolis, it’s known for its lush greenery, multicultural tapestry, and as a global financial hub. With a rich history and futuristic architecture, Singapore is a blend of tradition and modernity.

India is a vibrant country with a rich tapestry of history, culture, and diversity. It’s the world’s largest democracy, with a multitude of languages, religions, and traditions. Its landscapes range from Himalayan peaks to Indian Ocean coastline, reflecting its pluralistic and dynamic nature.

Japan, an archipelago in East Asia, boasts a rich cultural heritage and technological prowess. Its iconic cherry blossoms, ancient temples, and futuristic cities coexist harmoniously. Renowned for sushi, sumo wrestling, and anime, Japan captivates with its blend of tradition and innovation.





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
                                        id: ds['Id'],
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
                                Text(
                                  'Title: ' + ds["Title"],
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Image(
                                  image: NetworkImage(ds["Image"]),
                                  width: 100,
                                  height: 100,
                                ),
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





*/