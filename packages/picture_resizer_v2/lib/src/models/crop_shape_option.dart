import 'package:flutter/material.dart';

class CropShapeOption{
  final BoxShape shape;
  final String title;

  CropShapeOption(this.shape,this.title);

  static List<CropShapeOption> getTestingData() {
    return [
      CropShapeOption(BoxShape.rectangle, "Box"),
      CropShapeOption(BoxShape.circle, "Oval")
    ];
  }

}