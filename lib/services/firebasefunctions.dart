import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
class FirestoreServices{
  static saveUser(String email,uid) async{
    await FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .set({'email':email});
  }
 
}

