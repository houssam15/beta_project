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
  ValidConstraints? validConstraints;
  File? editedFile;

  SocialMediaErrorItem({
    required this.errorType,
    this.messages = const [],
    this.isEdited = false,
    this.isEditUploaded = false,
    this.validConstraints,
    this.editedFile
  });


  static SocialMediaErrorItem? fromRepository(dynamic data){
    try{
      return SocialMediaErrorItem(
          errorType: (data.errorType as String).toSocialMediaErrorType(),
          messages: data.messages,
          validConstraints: ValidConstraints.fromRepository(data.validConstraints)
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

  @override
  List<Object?> get props => [errorType,messages,isEdited,isEditUploaded,validConstraints,editedFile];
}

