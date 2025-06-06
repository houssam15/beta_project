// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Temperature _$TemperatureFromJson(Map<String, dynamic> json) =>
    Temperature(value: (json['value'] as num).toDouble());

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{'value': instance.value};

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
  condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
  lastUpdated: DateTime.parse(json['lastUpdated'] as String),
  location: json['location'] as String,
  temperature: Temperature.fromJson(
    (json['temperature'] as Temperature).toJson(),
  ),
);

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
  'condition': _$WeatherConditionEnumMap[instance.condition]!,
  'lastUpdated': instance.lastUpdated.toIso8601String(),
  'location': instance.location,
  'temperature': instance.temperature
};

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};
