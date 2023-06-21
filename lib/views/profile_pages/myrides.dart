import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel/views/profile_pages/ridedetail.dart';

import '../../services/database.dart';
import 'add_ride.dart';

class RideCart extends StatefulWidget {
  const RideCart({super.key});

  @override
  State<RideCart> createState() => _RideCartState();
}

class _RideCartState extends State<RideCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Rides"),
        ),
        body: Container(
          color: Color.fromARGB(255, 24, 23, 23),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('ride-table')
                  .where('riderList',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                                      .update({'riderList': ""});
                                },
                                child: Text("Delete ride request"))
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
