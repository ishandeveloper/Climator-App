import 'package:climate_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../locator.dart'; 

class ClimateLocation extends StatefulWidget {
  @override
  _ClimateLocationState createState() => _ClimateLocationState();
}

class _ClimateLocationState extends State<ClimateLocation> {

  void getLocation()async{
    Location position=Location();
    await position.getLocation();
  }

  @override
  void initState() { 
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.location_city,
            color: Colors.grey[900],
          ),
          // title: Text('Hi'),
          backgroundColor: Color.fromARGB(1000, 170, 255, 236),
          elevation: 0,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: GestureDetector(
                child: Icon(
                  Icons.info,
                  color: Colors.grey[900],
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              top: 80,
              left: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Find your location',
                  style: bigLocation.copyWith(fontSize: 30),
                ),
                Container(
                  margin:EdgeInsets.only(top:15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:BorderRadius.circular(30)
                  ),
                  padding: EdgeInsets.only(left:10),
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: TextField(
                    autofocus: false,
                    decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        border: InputBorder.none,
                        // helperText: 'Search For Any City',
                        hintText: 'Search for any city'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
