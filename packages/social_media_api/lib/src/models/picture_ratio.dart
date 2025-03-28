
import 'package:equatable/equatable.dart';
class PictureRatio extends Equatable{
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;
  final String ratio;

  PictureRatio({
    required this.minWidth,
    required this.maxWidth,
    required this.minHeight,
    required this.maxHeight,
    required this.ratio
  });

  static PictureRatio fromJson(data){
    try{
      return PictureRatio(
          minWidth: data["width_min"].toDouble(),
          maxWidth: data["width_max"].toDouble(),
          minHeight: data["height_min"].toDouble(),
          maxHeight: data["height_max"].toDouble(),
          ratio: data["ratio"]
      );
    }catch(err){
      rethrow;
    }
  }

  @override
  List<Object?> get props => [minWidth,minHeight,maxWidth,maxHeight,ratio];
}