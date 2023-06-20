import 'package:flutter/material.dart';
import 'package:wheel/views/home.dart';
import 'package:wheel/services/firebase_auth.dart';
import 'package:wheel/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheel/views/ride_list.dart';
import 'package:wheel/views/theme/rounded_input_field.dart';
//import 'package:groupool/theme/login_background.dart';
import 'package:wheel/views/theme/rounded_button.dart';

class AddRidePage extends StatefulWidget {
  static String email = '';
  const AddRidePage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AddRidePage> {
  String start_location = "";
  String end_location = "";
  String time = "10:00 AM";
  var rideList = [];
  var prefs, row;

  void initState() {
    getRideData().then(
      (data) {
        setState(() {
          if (data != null) {
            rideList = data;
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
            AddRidePage.email = '${value.getString('useremail')}';
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Center(child: const Text('Trip Register')),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          color: Color.fromARGB(255, 24, 23, 23),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 80,
                ),
                RoundedInputField(
                  key: ValueKey('start'),
                  hintText: "Enter Start Location",
                  onChanged: (value) {
                    start_location = value;
                  },
                ),
                RoundedInputField(
                  key: ValueKey('end'),
                  hintText: "Enter End Location",
                  onChanged: (value) {
                    end_location = value;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                TextButton(
                  child: const Text('Select time'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.red,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () => (() async {
                    time = await _selectTime(context) as String;
                    print(time);
                  }()),
                ),
                Text(
                  '${time}',
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                    child: const Text('Create Trip'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.red,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () => (() async {
                          if (start_location.isNotEmpty &&
                              end_location.isNotEmpty) {
                            var success_factor = addRide(start_location,
                                end_location, time, AddRidePage.email);
                          } else {}
                        }())),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'OR',
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx3) {
                              return RideListPage();
                            },
                          ),
                        ); //await loginhere();
                      },
                      child: const Text(
                        'Search a Trip',
                        style: TextStyle(fontSize: 15),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}

Future<String> _selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return picked!.format(context);
}
