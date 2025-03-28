

import 'package:equatable/equatable.dart';

import 'picture_ratio.dart';

class ConstraintPropertiesForVideo extends Equatable{
  /// supported extensions
  final List<String>? formats;
  /// Min duration on s
  final double? minDuration;
  /// Max duration on s
  final double? maxDuration;
  /// Supported ratios
  final List<PictureRatio> ratios;

  ConstraintPropertiesForVideo({
    required this.formats,
    required this.minDuration,
    required this.maxDuration,
    required this.ratios
  });

  static ConstraintPropertiesForVideo fromJson(dynamic data) {
    try{
      return ConstraintPropertiesForVideo(
          formats: data["formats"]?.map<String>((elm)=>elm.toString()).toList()??[],
          minDuration: data["duration_min"]?.toDouble() ,
          maxDuration: data["duration_max"]?.toDouble(),
          ratios: data["properties"]?.map<PictureRatio>((elm)=>PictureRatio.fromJson(elm)).toList()??[]
      );
    }catch(err){
      rethrow;
    }
  }

  @override
  List<Object?> get props => [formats,minDuration,maxDuration,ratios];
}