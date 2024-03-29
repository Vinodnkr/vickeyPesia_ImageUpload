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










*/