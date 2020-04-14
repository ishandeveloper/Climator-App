import 'package:climate_app/constants.dart';
import 'package:climate_app/pages/CimateHome.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../locator.dart'; 
String searchCity;
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
                    onChanged: (value){
                      setState(() {
                        searchCity=value;
                      });
                    },
                    onSubmitted: (value){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClimateHome(city: value,)));
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        border: InputBorder.none,
                        // helperText: 'Search For Any City',
                        hintText: 'Search for any city'),
                  ),
                ),
                MaterialButton(onPressed: (){
                  
                },child: searchCity!=null?Text("Get Weather For '$searchCity'"):Text(''),
                
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
