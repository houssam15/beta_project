
class ValidConstraints{
  final double minHeight;
  final double maxHeight;
  final double minWidth;
  final double maxWidth;

  ValidConstraints({
    required this.minHeight,
    required this.maxHeight,
    required this.minWidth,
    required this.maxWidth
  });

  static ValidConstraints? fromJson(dynamic data){
    if(data == null) return null;
    return ValidConstraints(
        maxHeight: data["maxHeight"].toDouble(),
        maxWidth: data["maxWidth"].toDouble(),
        minWidth: data["minWidth"].toDouble(),
        minHeight: data["minHeight"].toDouble()
    );
  }

}