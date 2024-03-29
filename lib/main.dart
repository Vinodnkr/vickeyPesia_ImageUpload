// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:p_1/pages/home_screen.dart';
import 'package:p_1/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define Named Routes
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) =>  HomeScreen(),
       // '/profile': (context) => const SecondScreen(),
      },
    );
  }
}
 

/*
 //1 pick image
                ImagePicker imagePicker = ImagePicker();
                 XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                     //print('${file?.path}');

                  //if (file == null) return ;
                  //unique file name
                  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                  //2 upload to firebase and get reference
                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference referenceDirImages = referenceRoot.child('images/');
                  print('2');

                  //3 reference image to store
                  Reference referenceImageToUpload =referenceDirImages.child(uniqueFileName);
                  print('3');

                  //4 store the file in firebase
                  try {
                    await referenceImageToUpload.putFile(File(XFile(file.path).path));
                    print('store in firebase');
                    //5 download url
                    imageUrl = await referenceImageToUpload.getDownloadURL();
                  } catch (e) {
                    //some error
                    print(e);
                  }
                },

                */