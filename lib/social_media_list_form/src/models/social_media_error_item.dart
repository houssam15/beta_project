part of 'models.dart';

enum SocialMediaErrorType{
  invalidDimensions,
  invalidFile
}

extension SocialMediaErrorTypeMapping on String{
  SocialMediaErrorType toSocialMediaErrorType(){
    switch(this){
      case "INVALID_DIMENSIONS" : return SocialMediaErrorType.invalidDimensions;
      default : return SocialMediaErrorType.invalidFile;
    }
  }
}

class SocialMediaErrorItem extends Equatable{
  final List<String> messages;
  final SocialMediaErrorType errorType;
  bool isEdited;
  bool isEditUploaded;
  List<ValidConstraintsByRatio> validConstraints;
  File? editedFile;
  Map<String,dynamic>? _exifData;

  SocialMediaErrorItem({
    required this.errorType,
    this.messages = const [],
    this.isEdited = false,
    this.isEditUploaded = false,
    this.validConstraints = const [],
    this.editedFile,
  });


  static SocialMediaErrorItem? fromRepository(fur.UploadDocumentResponseWarning data,SocialMediaListFormRemoteState state){
    try{
      if(data.messages.isEmpty) return null;
      List<ValidConstraintsByRatio> validCons = [];
      for(dynamic elm in state.constrains?.getConstraintByMediaTypeAndEngine(data.getSocialMediaItem().first.engine,state.mediaType) ?? []){
        dynamic con = ValidConstraintsByRatio.fromRepository(elm);
        if(con == null) continue;
        validCons.add(con);
      }
      return SocialMediaErrorItem(
          errorType: data.isFileRequireResize ? SocialMediaErrorType.invalidDimensions : SocialMediaErrorType.invalidFile,
          messages: data.messages,
          validConstraints: validCons
      );
    }catch(err){
      return null;
    }
  }

  double getNeededHeightForMessages({double multiplayer = 10}){
    double height = 0;
    for(String elm in messages){
      height = height + elm.length;
    }
    return height*multiplayer;
  }

  SocialMediaErrorItem setEditedFile(File file){
    editedFile = file;
    isEdited = true;
    return this;
  }

  SocialMediaErrorItem setExifData(Map<String,dynamic>? exifData){
    this._exifData = exifData;
    return this;
  }

  Map<String,dynamic>? getExifData(){
    return _exifData;
  }

  @override
  List<Object?> get props => [errorType,messages,isEdited,isEditUploaded,validConstraints,editedFile,_exifData];
}

