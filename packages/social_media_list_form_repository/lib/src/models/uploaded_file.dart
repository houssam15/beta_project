class UploadedFile {
  String? errorMessage;
  String? pictureUrl;

  setError(String error){
    errorMessage = error;
  }

  setPictureUrl(String url){
    pictureUrl = url;
  }

  bool hasError(){
    return errorMessage != null;
  }

  String? getPictureUrl(){
    return pictureUrl;
  }

}