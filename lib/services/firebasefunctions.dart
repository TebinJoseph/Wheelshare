import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel/views/login.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class FirestoreServices {
  static saveUser(String email, String name, uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'email': email, 'address': "25", 'phone': "45", 'name': name});
  }

 
}
