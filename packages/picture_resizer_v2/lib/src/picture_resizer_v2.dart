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
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        uiSettings: [
          AndroidUiSettings(
            aspectRatioPresets: getAspectRatios(),
            lockAspectRatio: false,
            showCropGrid: true,
            cropGridColumnCount: 2,
            cropGridRowCount: 2,
            hideBottomControls: false,
          ),
          IOSUiSettings(
            aspectRatioLockEnabled: false,
            resetAspectRatioEnabled: false,
            aspectRatioPickerButtonHidden: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              ...getAspectRatios()
            ],

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