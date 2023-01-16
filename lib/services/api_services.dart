import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather_app_with_api/services/weather_api.dart';

class ApiServices {
  final String _apiKey = "c85a45e814a467a3c14247cb74fa921a";

  Future getCityDataByCityName(String cityName) async {
    //List of cities
    // List<String> cities = [
    //   'Adoni',
    //   'Amaravati',
    // ];
    Map<String, dynamic> params = {'appid': _apiKey, 'q': cityName};
    final uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=${_apiKey}');
    try {
      var response = await http.get(uri);
      var data = jsonDecode(response.body);
      var finalData = WeatherApi.fromJson(data);
      log(finalData.toString());
      return finalData;
    } catch (e) {
      log(e.toString());
      throw Error();
    }
    ;
  }
}
