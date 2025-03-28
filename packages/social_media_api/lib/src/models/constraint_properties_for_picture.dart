import 'package:equatable/equatable.dart';
import 'picture_ratio.dart';

class ConstraintPropertiesForPicture extends Equatable{
  /// supported extensions
  final List<String> formats;
  /// Min size on octet
  final double minSize;
  /// Max size on octet
  final double maxSize;
  /// Supported ratios
  final List<PictureRatio> ratios;

  ConstraintPropertiesForPicture({
    required this.formats,
    required this.minSize,
    required this.maxSize,
    required this.ratios
  });

  static ConstraintPropertiesForPicture fromJson(dynamic data){
    try{
      return ConstraintPropertiesForPicture(
          formats: data["formats"]?.map<String>((elm)=>elm.toString()).toList()??[],
          minSize:data["min_size"].toDouble(),
          maxSize: data["max_size"].toDouble(),
          ratios: data["properties"]?.map<PictureRatio>((elm)=>PictureRatio.fromJson(elm)).toList()??[]
      );
    }catch(err){
      rethrow;
    }
  }

  @override
  List<Object?> get props => [formats,minSize,maxSize,ratios];
}