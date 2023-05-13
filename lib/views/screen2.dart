import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wheel/views/trip.dart';
import 'package:flutter/src/material/bottom_navigation_bar.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _fromcontroller = TextEditingController();
  final _tocontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 24, 23, 23),
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [Color(0x0fe6e5ed), Color(0xfff4f0f4)],
          // )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Choose Your Trip',
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  wordSpacing: 1,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 300,
              height: 40,
              child: TextFormField(
                controller: _fromcontroller,
                decoration: const InputDecoration(
                    filled: true,
                    hintText: "From",
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 179, 176, 186),
                        fontSize: 18,
                        fontStyle: FontStyle.normal),
                    contentPadding: EdgeInsets.all(8),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.location_on),
                    ),
                    prefixIconColor: Color.fromARGB(255, 203, 195, 195),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 300,
              height: 40,
              child: TextFormField(
                controller: _tocontroller,
                decoration: const InputDecoration(
                    filled: true,
                    hintText: "To",
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 179, 176, 186),
                        fontSize: 18,
                        fontStyle: FontStyle.normal),
                    contentPadding: EdgeInsets.all(8),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.location_on),
                    ),
                    prefixIconColor: Color.fromARGB(255, 203, 195, 195),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'OR',
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontSize: 30,
                  wordSpacing: 1,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx3) {
                          return Trip();
                        },
                      ),
                    ); //await loginhere();
                  },
                  child: const Text(
                    'Create a trip',
                    style: TextStyle(fontSize: 15),
                  )),
            ),
          ],
        ),
      ),

    );
  }
}
