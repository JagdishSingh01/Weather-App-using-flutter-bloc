import 'dart:convert';

class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final double currentPressure;
  final double currentWindSpeed;
  final double currentHumidity;

  final List<String> hourlySky;
  final List<double> hourlyTemp;
  final List<DateTime> time;

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,

    required this.hourlyTemp,
    required this.hourlySky,
    required this.time,
  });

  WeatherModel copyWith({
    double? currentTemp,
    String? currentSky,
    double? currentPressure,
    double? currentWindSpeed,
    double? currentHumidity,

    List<String>? hourlySky,
    List<double>? hourlyTemp,
    List<DateTime>? time,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,

      hourlySky: hourlySky ?? this.hourlySky,
      hourlyTemp: hourlyTemp ?? this.hourlyTemp,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,

      'hourlySky': hourlySky,
      'hourlyTemp': hourlyTemp,
      'time': time,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final List list = map['list'];

    final currentWeatherData = map['list'][0];

    // Parsing next 5 items for hourly forecast
    final hourlyTemp= <double>[];
    final hourlySky = <String>[];
    final time = <DateTime>[];

    for(int i=0;i<=5;i++){
      final item = list[i];
      hourlyTemp.add(double.parse((item['main']['temp'] - 273.15).toStringAsFixed(1)));
      hourlySky.add(item['weather'][0]['main']);
      time.add(DateTime.parse(item['dt_txt']));
    }

    return WeatherModel(
      currentTemp: double.parse(
        (currentWeatherData['main']['temp'] - 273.15).toStringAsFixed(1),
      ),
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure: (currentWeatherData['main']['pressure']).toDouble(),
      currentWindSpeed: (currentWeatherData['wind']['speed']).toDouble(),
      currentHumidity: (currentWeatherData['main']['humidity']).toDouble(),
      
      hourlyTemp: hourlyTemp,
      hourlySky: hourlySky,
      time:  time,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity &&

        other.hourlySky == hourlySky &&
        other.hourlyTemp == hourlyTemp &&
        other.time == time;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode ^

        hourlySky.hashCode ^
        hourlyTemp.hashCode ^
        time.hashCode ;
         
  }
}
