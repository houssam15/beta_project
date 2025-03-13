import "package:picture_resizer/picture_resizer.dart" as picture_resizer;

class ValidConstraints{
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;

  ValidConstraints({
    required this.minHeight,
    required this.maxHeight,
    required this.minWidth,
    required this.maxWidth
  });

  toPictureResizerModel(){
    return picture_resizer.ValidConstraints(
      minWidth: minWidth,
      minHeight: minHeight,
      maxWidth: maxWidth,
      maxHeight: maxHeight
    );
  }

  static ValidConstraints? fromJson(dynamic data){
    try{
      return ValidConstraints(
          minHeight: data.minHeight,
          maxHeight: data.maxHeight,
          minWidth: data.minWidth,
          maxWidth: data.maxWidth
      );
    }catch(err){
      return null;
    }
  }
}