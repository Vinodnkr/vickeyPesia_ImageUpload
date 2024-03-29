
// ignore_for_file: non_constant_identifier_names, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  //CRUD operation below
  //Create
  Future addListDetails(Map<String, dynamic> listInfoMap, String id) async{
    return await FirebaseFirestore.instance.collection("12345").doc(id).set(listInfoMap);
  }

//read
  Future<Stream<QuerySnapshot>> getListDetails() async {
    return await FirebaseFirestore.instance.collection("12345").snapshots();
  }
//update
Future UpdateListDetails(String Id, Map<String, dynamic> updateInfo) async{
  return await FirebaseFirestore.instance.collection('12345').doc(Id).set(updateInfo);
}

//delete
Future DeleteListDetails(String Id) async{
  return await FirebaseFirestore.instance.collection('12345').doc(Id).delete();
}
}

