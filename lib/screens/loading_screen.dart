import 'package:flutter/material.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weather = WeatherModel();

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  Future getWeatherData() async {
    return await weather.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getWeatherData(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: SpinKitDoubleBounce(
                color: Colors.deepOrange[300],
                size: 100.0,
              ),
            );
          }
          if(snapshot.data == 'failed') {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
              child: Column(
                children: [
                  Text('Operation Failed!', 
                  style: TextStyle(
                    fontFamily: 'Spartan MB',
                    fontSize: 20.0,
                    height: 1.5,
                    color: Colors.black87),
                  ),
                  SizedBox(height: 20.0,),
                  Text('Either your GPS is turned or location permission request is denied. Turn on GPS, grant location permission and Restart the app', 
                  style: TextStyle(
                    fontFamily: 'Spartan MB',
                    fontSize: 15.0,
                    height: 1.5,
                    color: Colors.black87),
                  ),
                  SizedBox(height: 30.0),
                  RaisedButton(
                    child: Text('Restart'),
                    color: Colors.blueGrey,
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoadingScreen()));
                    },
                  ),
                ],
              ),
            );
          }
          return LocationScreen(snapshot.data);
        }
      ),
    );
  }
}
