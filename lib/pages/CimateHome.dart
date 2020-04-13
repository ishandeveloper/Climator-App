import 'package:climate_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClimateHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.my_location,color: Colors.grey[900],),
          // title: Text('Hi'),
          backgroundColor: Color.fromARGB(1000, 170, 255, 236),
          elevation: 0,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right:10),
              child: GestureDetector(
                child: Icon(Icons.info,color: Colors.grey[900],),
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              top: 50,
              left: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Jalandhar',
                  style: bigLocation,
                ),

                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.cloudSunRain,size: 40,),
                    SizedBox(width: 20,),
                    Text(
                      '23' + '°C',
                      style: bigTemperature,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
