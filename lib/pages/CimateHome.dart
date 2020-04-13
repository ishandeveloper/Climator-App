import 'package:climate_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../locator.dart';

String cityName = 'Locating...';
String temperature = '0';
String feelslike='0';
String climateDescription='Fetching Data';
IconData climateIcon=FontAwesomeIcons.cloud;
class ClimateHome extends StatefulWidget {
  @override
  _ClimateHomeState createState() => _ClimateHomeState();
}

class _ClimateHomeState extends State<ClimateHome> {
  void getLocation() async {
    Location position = Location();
    await position.getLocation();
    // print(position.lattitude);
    getData(position.longitude, position.lattitude);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getData(double lon, double lat) async {
    try {
      Response res = await get(
          'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${APIKey}');
      // print(jsonDecode(res.body));
      // String data=jsonDecode(res.body);
      // print(temperature-273);
      setState(() {
        cityName = jsonDecode(res.body)['name'];
        climateDescription=(jsonDecode(res.body)['weather'][0]['description']);
        temperature = (jsonDecode(res.body)['main']['temp'] - 273).toStringAsFixed(1);
        feelslike = (jsonDecode(res.body)['main']['feels_like'] - 273).toStringAsFixed(1);
        if(jsonDecode(res.body)['weather'][0]['icon']=='03n'){
          climateIcon=FontAwesomeIcons.cloudSun;
        }
      });
    } catch (e) {
      print('Error making connection to server');
    }
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.my_location,
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
              top: 50,
              left: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(climateIcon,size: 50,),
                    SizedBox(width: 25,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          climateDescription.toUpperCase(),
                          style: bigLocation.copyWith(fontSize:16,fontWeight: FontWeight.w200),
                        ),
                        Text(
                          cityName,
                          style: bigLocation.copyWith(fontSize:30),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  margin: EdgeInsets.only(right:20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.temperatureLow,
                        size: 50,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            temperature + '°C',
                            style: bigLocation,
                          ),
                          Text(
                            'Feels like ' + feelslike+ '°C',
                            style: bigTempLabels,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
