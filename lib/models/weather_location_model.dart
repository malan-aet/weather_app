class WeatherLocationModel {
 final Location location;
 final CurrentCondition currentCondition;

const WeatherLocationModel({
   required this.location,
   required this.currentCondition,
 });

 factory WeatherLocationModel.fromJson(Map<String, dynamic> json) {
   return WeatherLocationModel(
     location: Location.fromJson(json["location"]),
     currentCondition: CurrentCondition.fromJson(json["current"]),
   );
 }

 Map<String, dynamic> toJson() {
   return {
     "location": location.toJson(),
     "current": currentCondition.toJson(),
   };
 }

 static List<WeatherLocationModel> parseList(dynamic jsonList) {
   if (jsonList == null || jsonList is! List || jsonList.isEmpty) {
     return [];
   }
   return jsonList.map((json) => WeatherLocationModel.fromJson(json)).toList();
 }
}


class Location {
 final String name;
 final String region;
 final String country;
 final double lat;
 final double lon;
 final String tzId;
 final int localtimeEpoch;
 final String localtime;

const Location({
   required this.name,
   required this.region,
   required this.country,
   required this.lat,
   required this.lon,
   required this.tzId,
   required this.localtimeEpoch,
   required this.localtime,
 });

 factory Location.fromJson(Map<String, dynamic> json) {
   return Location(
     name: json["name"],
     region: json["region"],
     country: json["country"],
     lat: json["lat"],
     lon: json["lon"],
     tzId: json["tz_id"],
     localtimeEpoch: json["localtime_epoch"],
     localtime: json["localtime"],
   );
 }

 Map<String, dynamic> toJson() {
   return {
     "name": name,
     "region": region,
     "country": country,
     "lat": lat,
     "lon": lon,
     "tz_id": tzId,
     "localtime_epoch": localtimeEpoch,
     "localtime": localtime,
   };
 }

 static List<Location> parseList(dynamic jsonList) {
   if (jsonList == null || jsonList is! List || jsonList.isEmpty) {
     return [];
   }
   return jsonList.map((json) => Location.fromJson(json)).toList();
 }
}


class CurrentCondition {
 final int lastUpdatedEpoch;
 final String lastUpdated;
 final double tempc;
 final double tempf;
 final int isDay;
 final Condition condition;
 final double windMph;
 final double windKph;
 final int windDegree;
 final String windDir;
 final int pressureMb;
 final double pressureIn;
 final double precipMm;
 final int precipIn;
 final int humidity;
 final int cloud;
 final double feelslikec;
 final double feelslikef;
 final double windchillc;
 final double windchillf;
 final double heatindexc;
 final double heatindexf;
 final double dewpointc;
 final double dewpointf;
 final int visKm;
 final int visMiles;
 final int uv;
 final double gustMph;
 final double gustKph;
 final double shortRad;
 final double diffRad;
 final int dni;
 final double gti;

const CurrentCondition({
   required this.lastUpdatedEpoch,
   required this.lastUpdated,
   required this.tempc,
   required this.tempf,
   required this.isDay,
   required this.condition,
   required this.windMph,
   required this.windKph,
   required this.windDegree,
   required this.windDir,
   required this.pressureMb,
   required this.pressureIn,
   required this.precipMm,
   required this.precipIn,
   required this.humidity,
   required this.cloud,
   required this.feelslikec,
   required this.feelslikef,
   required this.windchillc,
   required this.windchillf,
   required this.heatindexc,
   required this.heatindexf,
   required this.dewpointc,
   required this.dewpointf,
   required this.visKm,
   required this.visMiles,
   required this.uv,
   required this.gustMph,
   required this.gustKph,
   required this.shortRad,
   required this.diffRad,
   required this.dni,
   required this.gti,
 });

 factory CurrentCondition.fromJson(Map<String, dynamic> json) {
   return CurrentCondition(
     lastUpdatedEpoch: json["last_updated_epoch"],
     lastUpdated: json["last_updated"],
     tempc: json["temp_c"],
     tempf: json["temp_f"],
     isDay: json["is_day"],
     condition: Condition.fromJson(json["condition"]),
     windMph: json["wind_mph"],
     windKph: json["wind_kph"],
     windDegree: json["wind_degree"],
     windDir: json["wind_dir"],
     pressureMb: json["pressure_mb"],
     pressureIn: json["pressure_in"],
     precipMm: json["precip_mm"],
     precipIn: json["precip_in"],
     humidity: json["humidity"],
     cloud: json["cloud"],
     feelslikec: json["feelslike_c"],
     feelslikef: json["feelslike_f"],
     windchillc: json["windchill_c"],
     windchillf: json["windchill_f"],
     heatindexc: json["heatindex_c"],
     heatindexf: json["heatindex_f"],
     dewpointc: json["dewpoint_c"],
     dewpointf: json["dewpoint_f"],
     visKm: json["vis_km"],
     visMiles: json["vis_miles"],
     uv: json["uv"],
     gustMph: json["gust_mph"],
     gustKph: json["gust_kph"],
     shortRad: json["short_rad"],
     diffRad: json["diff_rad"],
     dni: json["dni"],
     gti: json["gti"],
   );
 }

 Map<String, dynamic> toJson() {
   return {
     "last_updated_epoch": lastUpdatedEpoch,
     "last_updated": lastUpdated,
     "temp_c": tempc,
     "temp_f": tempf,
     "is_day": isDay,
     "condition": condition.toJson(),
     "wind_mph": windMph,
     "wind_kph": windKph,
     "wind_degree": windDegree,
     "wind_dir": windDir,
     "pressure_mb": pressureMb,
     "pressure_in": pressureIn,
     "precip_mm": precipMm,
     "precip_in": precipIn,
     "humidity": humidity,
     "cloud": cloud,
     "feelslike_c": feelslikec,
     "feelslike_f": feelslikef,
     "windchill_c": windchillc,
     "windchill_f": windchillf,
     "heatindex_c": heatindexc,
     "heatindex_f": heatindexf,
     "dewpoint_c": dewpointc,
     "dewpoint_f": dewpointf,
     "vis_km": visKm,
     "vis_miles": visMiles,
     "uv": uv,
     "gust_mph": gustMph,
     "gust_kph": gustKph,
     "short_rad": shortRad,
     "diff_rad": diffRad,
     "dni": dni,
     "gti": gti,
   };
 }

 static List<CurrentCondition> parseList(dynamic jsonList) {
   if (jsonList == null || jsonList is! List || jsonList.isEmpty) {
     return [];
   }
   return jsonList.map((json) => CurrentCondition.fromJson(json)).toList();
 }
}


class Condition {
 final String text;
 final String icon;
 final int code;

const Condition({
   required this.text,
   required this.icon,
   required this.code,
 });

 factory Condition.fromJson(Map<String, dynamic> json) {
   return Condition(
     text: json["text"],
     icon: json["icon"],
     code: json["code"],
   );
 }

 Map<String, dynamic> toJson() {
   return {
     "text": text,
     "icon": icon,
     "code": code,
   };
 }

 static List<Condition> parseList(dynamic jsonList) {
   if (jsonList == null || jsonList is! List || jsonList.isEmpty) {
     return [];
   }
   return jsonList.map((json) => Condition.fromJson(json)).toList();
 }
}
