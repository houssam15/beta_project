import "package:social_media_api/social_media_api.dart" as social_media_api;

class Constrains extends social_media_api.Constrains{
  String? _errorMessage;
  late social_media_api.Constrains _constrains;

  setErrorMessage(String err){
    _errorMessage = err;
    return this;
  }

  String? getErrorMessage(){
    return _errorMessage;
  }

  bool isValid(){
    return _errorMessage == null;
  }

  setConstrainsFromApi(social_media_api.Constrains constrains){
    _constrains = constrains;
    return this;
  }

  List<String>? getGlobalPictureFormats(){
    return _constrains.globalProperties?.constraintPropertiesForPicture.formats;
  }

  List<String>? getGlobalVideoFormats(){
    return _constrains.globalProperties?.constraintPropertiesForVideo.formats;
  }

  double? getGlobalPictureMinSize(){
    return _constrains.globalProperties?.constraintPropertiesForPicture.minSize;
  }

  double? getGlobalPictureMaxSize(){
    return _constrains.globalProperties?.constraintPropertiesForPicture.maxSize;
  }

  double? getGlobalVideoMinSize(){
    return null;
  }

  double? getGlobalVideoMaxSize(){
    return null;
  }

  List<social_media_api.PictureRatio> getPictureConstraintByEngine(String? engine){
    try{
      return _constrains.socialMediaItemWithConstrains.firstWhere((elm)=>elm.engine.toLowerCase()==engine).constraintProperties.constraintPropertiesForPicture.ratios;
    }catch(err){
      return [];
    }
  }






}