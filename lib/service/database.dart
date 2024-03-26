
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future addListDetails(Map<String, dynamic> listInfoMap, String id) async{
    return await FirebaseFirestore.instance.collection("12345").doc(id).set(listInfoMap);
  }


  Future<Stream<QuerySnapshot>> getListDetails() async {
    return await FirebaseFirestore.instance.collection("12345").snapshots();
  }

  static UpdateListDetails(String id, Map<String, dynamic> updateInfo) {}
}

Future UpdateListDetails(String Id, Map<String, dynamic> updateInfo) async{
  return await FirebaseFirestore.instance.collection('12345').doc(Id).set(updateInfo);
}