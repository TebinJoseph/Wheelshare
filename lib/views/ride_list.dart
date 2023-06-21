import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wheel/views/home.dart';
import 'package:wheel/services/firebase_auth.dart';
import 'package:wheel/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel/views/profile_pages/add_ride.dart';
import 'package:wheel/views/theme/rounded_input_field.dart';
//import 'package:groupool/theme/login_background.dart';
import 'package:wheel/views/theme/rounded_button.dart';

class RideListPage extends StatefulWidget {
  const RideListPage({Key? key}) : super(key: key);
  @override
  State<RideListPage> createState() => _RideListPageState();
}

class _RideListPageState extends State<RideListPage> {
  final TextEditingController _filter = TextEditingController();
  var rideList = [];
  Widget _appBarTitle = const Text('Ride list');
  Icon _searchIcon = new Icon(Icons.search, color: Colors.white);
  var prefs, row;
  String email = '';
  String _searchText = "";
  List filteredRides = [];

  _RideListPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredRides = rideList;
          // filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    getRideData().then(
      (data) {
        setState(() {
          //rideData = data;

          if (data != null) {
            rideList = data;
            filteredRides = rideList;
          }
        });
      },
    );
    initPrefs();
    super.initState();
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance().then((value) => {
          setState(() {
            prefs = value;
            email = '${value.getString('email')}';
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All available rides"),
        ),
        body: Container(
          color: Color.fromARGB(255, 24, 23, 23),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('ride-table')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final DocumentSnapshot rides = snapshot.data!.docs[index];
                      String a = snapshot.data!.docs[index].id;
                      return Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          child: Column(children: [
                            Row(
                              children: [
                                Text(
                                  rides['start'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "  to  ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  rides['end'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  rides['time'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  rides['email'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('ride-table')
                                      .doc(a)
                                      .update({
                                    'riderList':
                                        FirebaseAuth.instance.currentUser!.uid
                                  });
                                },
                                child: Text("Request"))
                          ]),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                } else {
                  return const Center(child: Text("No data Available"));
                }
              }),
        ));
  }
}

Map fetchRideList(dbREF) {
  return {};
}

class CustomTile {
  var start;
  var end;
  var time;
  CustomTile(this.start, this.end, this.time);
}

List generateTile(rideList) {
  List l = [];
  for (var i in rideList) {
    l.add(i);
  }
  return l;
}
