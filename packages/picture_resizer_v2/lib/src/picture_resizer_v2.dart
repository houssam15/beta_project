import "dart:io";

import "package:flutter/material.dart";

import "../src/models/valid_constraints.dart";
import 'package:image_cropper/image_cropper.dart';

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  CropAspectRatioPresetCustom({
    required this.aspectName,
    required this.aspectValue
  });

  (int, int)? aspectValue;
  String aspectName;

  @override
  (int, int)? get data => aspectValue;

  @override
  String get name => aspectName;
}

class CropperProperties {
  CropAspectRatio aspectRatio;
  ValidConstraints validConstraint;

  CropperProperties._(this.aspectRatio,this.validConstraint);

  static CropperProperties create(ValidConstraints vc){
    return CropperProperties._(
        CropAspectRatio(
            ratioX:double.parse(vc.ratio.split(":")[0]) ,
            ratioY:double.parse(vc.ratio.split(":")[1])
        ),
        vc
    );
  }

}



class PictureResizerV2 {
  PictureResizerV2({
    required this.file,
    required this.context,
    required this.validConstraints,
    required this.extension
  });
  File file;
  BuildContext context;
  List<ValidConstraints> validConstraints;
  String? extension;

  List<CropAspectRatioPresetCustom> getAspectRatios(){
    return validConstraints.map<CropAspectRatioPresetCustom>((elm)=>CropAspectRatioPresetCustom(
        aspectName: elm.ratio,
        aspectValue: elm.toAspectRatio()
    )).toList();
  }



  Future<String?> cropPicture() async {
    try{
      CropperProperties cp = CropperProperties.create(validConstraints.first);

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: cp.aspectRatio,
        maxHeight: cp.validConstraint.maxHeight.toInt(),
        maxWidth: cp.validConstraint.maxWidth.toInt(),
        uiSettings: [
          AndroidUiSettings(
            //aspectRatioPresets: getAspectRatios(),
            lockAspectRatio: true,
            showCropGrid: true,
            cropGridColumnCount: 2,
            cropGridRowCount: 2,
            hideBottomControls: false,
          ),
          IOSUiSettings(
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
            aspectRatioPickerButtonHidden: false,
            /*aspectRatioPresets: [
              ...getAspectRatios(),
             /* CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,*/

            ],*/
          )
        ],
      );

    //debug
    return croppedFile?.path;
    }catch(err){
      return null;
    }
  }
}