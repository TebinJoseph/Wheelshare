import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;




Future<String> addRide(
    String start, String end, String time, String email) async {
  //String start='', end='', name = '', time = '';
  SharedPreferences.getInstance().then((prefs) => {
        firestore.collection('ride-table').add({
          'start': '${start}',
          'end': '${end}',
          'time': '${time}',
          'email': '${email}'
        }).then((value) => {print('Added Ride in DB')})
      });
  return 'Success';
}



Future<List?> getRideData() async {
  Future<Map> data;
  List rideList = [];
  Map rideList1 = {};
  List templist = [];
  try {
    var snapshot = await firestore.collection('ride-table').get();
    for (var doc in snapshot.docs) {
      rideList1 = doc.data();
      rideList1.putIfAbsent('id', () => doc.id);
      rideList.add(rideList1);
    }
    return rideList;
  } catch (e) {}
}
Future<dynamic> addRider(String riderEmail, String docID) async {
  try {
    var document =
        FirebaseFirestore.instance.collection('ride-table').doc(docID);

    var snapshot = await document.get();
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();
      var value = data?['riderList'];

      if (!value.contains(riderEmail) && value.length <= 5) {
        value.add(riderEmail);
        document.update({'riderList': value});
      }
    }
  } catch (e) {}
}




