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

  bool isValid(){
    return maxWidth>minWidth && maxHeight>minHeight;
  }
}