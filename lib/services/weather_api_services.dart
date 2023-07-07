import 'dart:convert';

import 'package:http/http.dart' as http;
import '../exceptions/weather_exception.dart';
import '../models/weather.dart';
import 'http_error_handler.dart';

class WeatherApiServices {
  Future<Weather> getWeather(String city) async {
    final Uri uri = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'q': city,
        'appid': "b5bedb63d4f648d38784f1b284518479",
        'units': 'metric'
      },
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      } else {
        late final responseBody = json.decode(response.body);

        if (responseBody.isEmpty) {
          throw WeatherException('Tidak bisa mendapatkan cuaca kota');
        }

        return Weather.fromJson(responseBody);
      }
    } catch (e) {
      rethrow;
    }
  }
}
