import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/src/common/app_config.dart';
import 'package:weather/src/common/dio/api.dart';
import 'package:weather/src/controller/weather_effects_controller.dart';
import 'package:weather/src/model/current_weather.dart';

class HomeController extends GetxController {
  RxBool currentWeatherLoading = false.obs;
  dynamic currentWeatherData;

  getCurrentLocation()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  currentWeather(lat,lon) async {
    try{
      currentWeatherLoading.value=true;
      var response = await Api.apiGet(
        'weather',
        {
          'lat':lat,
          'lon': lon,
          'appid': appid,
        }
      );
      if (response != null) {
        var mapData = CurrentWeather.fromJson(response);
        currentWeatherData = mapData;
        return true;
      }
    }
    finally{
      if(currentWeatherData.weather!=null){
        WeatherEffectsController weatherCon = Get.find();
        weatherCon.setWeather(currentWeatherData.weather[0].main);
      }
      currentWeatherLoading.value=false;
    }
  }
}