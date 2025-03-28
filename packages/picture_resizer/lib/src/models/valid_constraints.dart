class ValidConstraints{
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;
  final String ratio;
  ValidConstraints({
    required this.minHeight,
    required this.maxHeight,
    required this.minWidth,
    required this.maxWidth,
    required this.ratio
  });

  bool isValid(){
    return maxWidth>minWidth && maxHeight>minHeight;
  }

  double? toValue(){
    try{
      List<String> values = ratio.split(":");
      return double.parse(values[0])/double.parse(values[1]);
    }catch(err){
      return null;
    }

  }
}