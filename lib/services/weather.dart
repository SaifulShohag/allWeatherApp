import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey = '09b5e1630f06ffaa08b209daf5a30ddd';
const weatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel { 
  Future getCityWeather(String city) async {
    try {
      NetworkHelper networkHelper = 
        NetworkHelper('$weatherUrl?q=$city&appid=$apikey&units=metric');
      var weatherData = await networkHelper.getData();
      return weatherData;
    }catch(e) {
      return 400;
    }
  }

  Future getWeather() async {
    try {
      Location location = Location();
        await location.getCurrentLocation();
      NetworkHelper networkHelper = 
        NetworkHelper('$weatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric');

      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      return 'failed';
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s🍦time';
    } else if (temp > 20) {
      return 'Time for shorts and👕';
    } else if (temp < 10) {
      return 'You\'ll need🧣 and🧤';
    } else {
      return 'Bring a🧥just in case';
    }
  }
}
