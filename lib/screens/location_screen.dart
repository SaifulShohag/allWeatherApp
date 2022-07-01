import 'package:clima/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.weatherData);
  final weatherData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temperature;
  int condition;
  String place;
  String weatherIcon;
  String weatherMessage;
  String description;
  int feelsLike;
  int humidity;
  double windSpeed;
  int pressure;
  DateTime sunRise;
  DateTime sunSet; 

  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(data) {
    setState(() {
      if (data == 400) {
        temperature = 0;
        condition = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to fetch weather data';
        description = '';
        place = '';
        feelsLike = 0;
        humidity = 0;
        windSpeed = 0;
        pressure = 0;
        sunRise = DateTime.parse('1619825060');
        sunSet = DateTime.parse('1619871998');
      } else {
        temperature = data['main']['temp'].toInt();
        condition = data['weather'][0]['id'];
        description = data['weather'][0]['main'];
        weatherIcon = weatherModel.getWeatherIcon(condition);
        weatherMessage = weatherModel.getMessage(temperature);
        place = data['name'];
        feelsLike = data['main']['feels_like'].toInt();
        humidity = data['main']['humidity'].toInt();
        windSpeed = double.parse(data['wind']['speed'].toString());
        pressure = data['main']['pressure'].toInt();
        sunRise = DateTime.fromMillisecondsSinceEpoch(data['sys']['sunrise'] * 1000);
        sunSet = DateTime.fromMillisecondsSinceEpoch(data['sys']['sunset'] * 1000);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoadingScreen()));
                    },
                    icon: Icon(
                      Icons.near_me, 
                      size: 35.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if(typedName != null) {
                        var weatherData = await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    icon: Icon(
                      Icons.search,
                      size: 35.0,
                    ),
                  ),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 25.0,    
                      ),
                      Text(
                        '$place',
                        style: kConditionTextStyle,
                      ),
                    ], 
                  ),
                  Text(
                    '$temperature°C',
                    style: kTempTextStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$description ',
                        style: kConditionTextStyle,
                      ),
                      Text(
                        '$weatherIcon',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Feels Like: ',
                        style: kConditionTextStyle,
                      ),
                      Text(
                        '$feelsLike°C',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        children: [
                          Text(
                            'Humidity',
                            style: smallDetails,
                          ),
                          SleekCircularSlider(
                            appearance: CircularSliderAppearance(
                              customColors: CustomSliderColors(
                                progressBarColor: Colors.blue[600],
                                trackColor: Colors.blue[100],
                              ),
                              customWidths: CustomSliderWidths(
                                progressBarWidth: 7.0,
                                trackWidth: 4.0,
                              ),
                              infoProperties: InfoProperties(
                                mainLabelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0
                                ),
                              ),
                            ),
                            min: 0,
                            max: 100,
                            initialValue: humidity.toDouble(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sun Rise: '+sunRise.hour.toString()+':'+sunRise.minute.toString(),
                          style: smallDetails,
                        ),
                        Text(
                          'Sun Set: '+sunSet.hour.toString()+':'+sunSet.minute.toString(),
                          style: smallDetails,
                        ),
                        Text(
                          'Wind Speed: '+windSpeed.toString()+"m/s",
                          style: smallDetails,
                        ),
                        Text(
                          'Pressure: '+pressure.toString()+" P",
                          style: smallDetails,
                        )
                      ],
                  ),
                    )),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, bottom: 40.0, right: 15.0),
                child: Text(
                  "$weatherMessage in $place!",
                  style: kMessageTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
