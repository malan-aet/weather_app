class ForecastModel {
  String? date;
  int? dateEpoch;
  Day? day;
  Astro? astro;
  List<HourForecast>? hour;

  ForecastModel({this.date, this.dateEpoch, this.day, this.astro, this.hour});

  ForecastModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateEpoch = json['date_epoch']?.toInt();
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
    astro = json['astro'] != null ? Astro.fromJson(json['astro']) : null;
    if (json['hour'] != null) {
      hour = <HourForecast>[];
      json['hour'].forEach((v) {
        hour!.add(HourForecast.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['date_epoch'] = dateEpoch;
    if (day != null) {
      data['day'] = day!.toJson();
    }
    if (astro != null) {
      data['astro'] = astro!.toJson();
    }
    if (hour != null) {
      data['hour'] = hour!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Day {
  double? maxtempC;
  int? maxtempF;
  int? mintempC;
  double? mintempF;
  int? avgtempC;
  double? avgtempF;
  int? maxwindMph;
  double? maxwindKph;
  double? totalprecipMm;
  double? totalprecipIn;
  int? totalsnowCm;
  int? avgvisKm;
  int? avgvisMiles;
  int? avghumidity;
  int? dailyWillItRain;
  int? dailyChanceOfRain;
  int? dailyWillItSnow;
  int? dailyChanceOfSnow;
  Condition? condition;
  double? uv;

  Day({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.totalsnowCm,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
    this.uv,
  });

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c']?.toDouble();
    maxtempF = json['maxtemp_f']?.toInt();
    mintempC = json['mintemp_c']?.toInt();
    mintempF = json['mintemp_f']?.toDouble();
    avgtempC = json['avgtemp_c']?.toInt();
    avgtempF = json['avgtemp_f']?.toDouble();
    maxwindMph = json['maxwind_mph']?.toInt();
    maxwindKph = json['maxwind_kph']?.toDouble();
    totalprecipMm = json['totalprecip_mm']?.toDouble();
    totalprecipIn = json['totalprecip_in']?.toDouble();
    totalsnowCm = json['totalsnow_cm']?.toInt();
    avgvisKm = json['avgvis_km']?.toInt();
    avgvisMiles = json['avgvis_miles']?.toInt();
    avghumidity = json['avghumidity']?.toInt();
    dailyWillItRain = json['daily_will_it_rain']?.toInt();
    dailyChanceOfRain = json['daily_chance_of_rain']?.toInt();
    dailyWillItSnow = json['daily_will_it_snow']?.toInt();
    dailyChanceOfSnow = json['daily_chance_of_snow']?.toInt();
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    uv = json['uv']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maxtemp_c'] = maxtempC;
    data['maxtemp_f'] = maxtempF;
    data['mintemp_c'] = mintempC;
    data['mintemp_f'] = mintempF;
    data['avgtemp_c'] = avgtempC;
    data['avgtemp_f'] = avgtempF;
    data['maxwind_mph'] = maxwindMph;
    data['maxwind_kph'] = maxwindKph;
    data['totalprecip_mm'] = totalprecipMm;
    data['totalprecip_in'] = totalprecipIn;
    data['totalsnow_cm'] = totalsnowCm;
    data['avgvis_km'] = avgvisKm;
    data['avgvis_miles'] = avgvisMiles;
    data['avghumidity'] = avghumidity;
    data['daily_will_it_rain'] = dailyWillItRain;
    data['daily_chance_of_rain'] = dailyChanceOfRain;
    data['daily_will_it_snow'] = dailyWillItSnow;
    data['daily_chance_of_snow'] = dailyChanceOfSnow;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['uv'] = uv;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['icon'] = icon;
    data['code'] = code;
    return data;
  }
}

class Astro {
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  int? moonIllumination;
  int? isMoonUp;
  int? isSunUp;

  Astro({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
    this.isMoonUp,
    this.isSunUp,
  });

  Astro.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    moonIllumination = json['moon_illumination']?.toInt();
    isMoonUp = json['is_moon_up']?.toInt();
    isSunUp = json['is_sun_up']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['moonrise'] = moonrise;
    data['moonset'] = moonset;
    data['moon_phase'] = moonPhase;
    data['moon_illumination'] = moonIllumination;
    data['is_moon_up'] = isMoonUp;
    data['is_sun_up'] = isSunUp;
    return data;
  }
}

class HourForecast {
  int? timeEpoch;
  String? time;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windMph;
  double? windKph;
  int? windDegree;
  String? windDir;
  int? pressureMb;
  double? pressureIn;
  double? precipMm;
  int? precipIn;
  int? snowCm;
  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? windchillC;
  double? windchillF;
  double? heatindexC;
  double? heatindexF;
  double? dewpointC;
  double? dewpointF;
  int? willItRain;
  int? chanceOfRain;
  int? willItSnow;
  int? chanceOfSnow;
  int? visKm;
  int? visMiles;
  double? gustMph;
  double? gustKph;
  double? uv;
  double? shortRad;
  double? diffRad;
  double? dni;
  double? gti;

  HourForecast({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.snowCm,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
    this.visKm,
    this.visMiles,
    this.gustMph,
    this.gustKph,
    this.uv,
    this.shortRad,
    this.diffRad,
    this.dni,
    this.gti,
  });

  HourForecast.fromJson(Map<String, dynamic> json) {
    timeEpoch = json['time_epoch']?.toInt();
    time = json['time'];
    tempC = json['temp_c']?.toDouble();
    tempF = json['temp_f']?.toDouble();
    isDay = json['is_day']?.toInt();
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windMph = json['wind_mph']?.toDouble();
    windKph = json['wind_kph']?.toDouble();
    windDegree = json['wind_degree']?.toInt();
    windDir = json['wind_dir'];
    pressureMb = json['pressure_mb']?.toInt();
    pressureIn = json['pressure_in']?.toDouble();
    precipMm = json['precip_mm']?.toDouble();
    precipIn = json['precip_in']?.toInt();
    snowCm = json['snow_cm']?.toInt();
    humidity = json['humidity']?.toInt();
    cloud = json['cloud']?.toInt();
    feelslikeC = json['feelslike_c']?.toDouble();
    feelslikeF = json['feelslike_f']?.toDouble();
    windchillC = json['windchill_c']?.toDouble();
    windchillF = json['windchill_f']?.toDouble();
    heatindexC = json['heatindex_c']?.toDouble();
    heatindexF = json['heatindex_f']?.toDouble();
    dewpointC = json['dewpoint_c']?.toDouble();
    dewpointF = json['dewpoint_f']?.toDouble();
    willItRain = json['will_it_rain']?.toInt();
    chanceOfRain = json['chance_of_rain']?.toInt();
    willItSnow = json['will_it_snow']?.toInt();
    chanceOfSnow = json['chance_of_snow']?.toInt();
    visKm = json['vis_km']?.toInt();
    visMiles = json['vis_miles']?.toInt();
    gustMph = json['gust_mph']?.toDouble();
    gustKph = json['gust_kph']?.toDouble();
    uv = json['uv']?.toDouble();
    shortRad = json['short_rad']?.toDouble();
    diffRad = json['diff_rad']?.toDouble();
    dni = json['dni']?.toDouble();
    gti = json['gti']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time_epoch'] = timeEpoch;
    data['time'] = time;
    data['temp_c'] = tempC;
    data['temp_f'] = tempF;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_mph'] = windMph;
    data['wind_kph'] = windKph;
    data['wind_degree'] = windDegree;
    data['wind_dir'] = windDir;
    data['pressure_mb'] = pressureMb;
    data['pressure_in'] = pressureIn;
    data['precip_mm'] = precipMm;
    data['precip_in'] = precipIn;
    data['snow_cm'] = snowCm;
    data['humidity'] = humidity;
    data['cloud'] = cloud;
    data['feelslike_c'] = feelslikeC;
    data['feelslike_f'] = feelslikeF;
    data['windchill_c'] = windchillC;
    data['windchill_f'] = windchillF;
    data['heatindex_c'] = heatindexC;
    data['heatindex_f'] = heatindexF;
    data['dewpoint_c'] = dewpointC;
    data['dewpoint_f'] = dewpointF;
    data['will_it_rain'] = willItRain;
    data['chance_of_rain'] = chanceOfRain;
    data['will_it_snow'] = willItSnow;
    data['chance_of_snow'] = chanceOfSnow;
    data['vis_km'] = visKm;
    data['vis_miles'] = visMiles;
    data['gust_mph'] = gustMph;
    data['gust_kph'] = gustKph;
    data['uv'] = uv;
    data['short_rad'] = shortRad;
    data['diff_rad'] = diffRad;
    data['dni'] = dni;
    data['gti'] = gti;
    return data;
  }
}
