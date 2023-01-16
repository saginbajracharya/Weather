// To parse this JSON data, do
//
//     final currentWeather = currentWeatherFromJson(jsonString);

import 'dart:convert';

CurrentWeather currentWeatherFromJson(String str) => CurrentWeather.fromJson(json.decode(str));

String currentWeatherToJson(CurrentWeather data) => json.encode(data.toJson());

class CurrentWeather {
  CurrentWeather({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Rain? rain;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
    coord: Coord.fromJson(json["coord"]),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    base: json["base"],
    main: json["main"]==null?null:Main.fromJson(json["main"]),
    visibility: json["visibility"],
    wind: json["wind"]==null?null:Wind.fromJson(json["wind"]),
    rain: json["rain"]==null?null:Rain.fromJson(json["rain"]),
    clouds: json["clouds"]==null?null:Clouds.fromJson(json["clouds"]),
    dt: json["dt"],
    sys: json["sys"]==null?null:Sys.fromJson(json["sys"]),
    timezone: json["timezone"],
    id: json["id"],
    name: json["name"],
    cod: json["cod"],
  );

  Map<String, dynamic> toJson() => {
    "coord": coord!.toJson(),
    "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
    "base": base,
    "main": main!.toJson(),
    "visibility": visibility,
    "wind": wind!.toJson(),
    "rain": rain!.toJson(),
    "clouds": clouds!.toJson(),
    "dt": dt,
    "sys": sys!.toJson(),
    "timezone": timezone,
    "id": id,
    "name": name,
    "cod": cod,
  };
}

class Clouds {
  Clouds({
    this.all,
  });

  String? all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class Coord {
  Coord({
    this.lon,
    this.lat,
  });

  String? lon;
  String? lat;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lon: json["lon"].toString(),
    lat: json["lat"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "lon": lon,
    "lat": lat,
  };
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  String? temp;
  String? feelsLike;
  String? tempMin;
  String? tempMax;
  String? pressure;
  String? humidity;
  String? seaLevel;
  String? grndLevel;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"].toString(),
    feelsLike: json["feels_like"].toString(),
    tempMin: json["temp_min"].toString(),
    tempMax: json["temp_max"].toString(),
    pressure: json["pressure"].toString(),
    humidity: json["humidity"].toString(),
    seaLevel: json["sea_level"].toString(),
    grndLevel: json["grnd_level"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "humidity": humidity,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
  };
}

class Rain {
  Rain({
    this.the1H,
  });

  String? the1H;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    the1H: json["1h"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "1h": the1H,
  };
}

class Sys {
  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  String? type;
  String? id;
  String? country;
  String? sunrise;
  String? sunset;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    type: json["type"].toString(),
    id: json["id"].toString(),
    country: json["country"].toString(),
    sunrise: json["sunrise"].toString(),
    sunset: json["sunset"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "country": country,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  String? id;
  String? main;
  String? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"].toString(),
    main: json["main"].toString(),
    description: json["description"].toString(),
    icon: json["icon"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

class Wind {
  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  String? speed;
  String? deg;
  String? gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"].toString(),
    deg: json["deg"].toString(),
    gust: json["gust"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}
