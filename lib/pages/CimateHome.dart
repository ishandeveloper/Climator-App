import 'package:climate_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../locator.dart';

String cityName = 'Locating...';
String temperature = '0';
String feelslike = '0';
String climateDescription = 'Fetching Data';
IconData climateIcon = FontAwesomeIcons.cloud;
String humidity = '0';
String pressure = '0';

class ClimateHome extends StatefulWidget {
  final double longitude;
  final double lattitude;
  ClimateHome({this.longitude, this.lattitude});
  @override
  _ClimateHomeState createState() => _ClimateHomeState(longitude: longitude,lattitude: lattitude);
}

class _ClimateHomeState extends State<ClimateHome> {
  double longitude;
  double lattitude;
  _ClimateHomeState({this.longitude,this.lattitude});
  void getLocation() async {
    if(longitude==null || lattitude==null){
    Location position = Location();
    await position.getLocation();
    longitude=position.longitude;
    lattitude=position.lattitude;
    }
    // print(position.lattitude);
    getData(longitude, lattitude);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getData(double lon, double lat) async {
    try {
      Response res = await get(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$APIKey');
      print(jsonDecode(res.body));
      // String data=jsonDecode(res.body);
      // print(temperature-273);
      setState(() {
        cityName = jsonDecode(res.body)['name'];
        climateDescription =
            (jsonDecode(res.body)['weather'][0]['description']);
        temperature =
            (jsonDecode(res.body)['main']['temp'] - 273).toStringAsFixed(1);
        feelslike = (jsonDecode(res.body)['main']['feels_like'] - 273)
            .toStringAsFixed(1);
        humidity =
            (jsonDecode(res.body)['main']['humidity']).toStringAsFixed(0);
        pressure =
            (jsonDecode(res.body)['main']['pressure']).toStringAsFixed(0);

        if (jsonDecode(res.body)['weather'][0]['icon'] == '03n') {
          climateIcon = FontAwesomeIcons.cloudSun;
        } else if (jsonDecode(res.body)['weather'][0]['icon'] == '04d') {
          climateIcon = FontAwesomeIcons.cloudMoon;
        } else if (jsonDecode(res.body)['weather'][0]['icon'] == '09d') {
          climateIcon = FontAwesomeIcons.cloudRain;
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
            FontAwesomeIcons.wind,
            color: Colors.grey[900],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Climator',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              Text(
                'by ishandeveloper',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 10,
                ),
              )
            ],
          ),
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/locator');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, blurRadius: 2)
                        ]),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          climateIcon,
                          size: 50,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              climateDescription.toUpperCase(),
                              style: bigLocation.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w200),
                            ),
                            Text(
                              cityName,
                              style: bigLocation.copyWith(fontSize: 30),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      // margin: EdgeInsets.only(right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                            )
                          ],
                        ),
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 10,
                          bottom: 10,
                        ),
                        width: MediaQuery.of(context).size.width * 0.41,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.temperatureLow,
                              size: 30,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  temperature + '°C',
                                  style: bigLocation.copyWith(fontSize: 24),
                                ),
                                Text(
                                  'Feels like ' + feelslike + '°C',
                                  style: bigTempLabels.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      // margin: EdgeInsets.only(right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                            )
                          ],
                        ),
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 10,
                          bottom: 10,
                        ),
                        width: MediaQuery.of(context).size.width * 0.41,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.water,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  pressure + ' Pa',
                                  style: bigLocation.copyWith(fontSize: 24),
                                ),
                                Text(
                                  'Humidity : ' + humidity + '%',
                                  style: bigTempLabels.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
