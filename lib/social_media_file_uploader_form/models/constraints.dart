import "package:file_uploader_repository/file_uploader_repository.dart" as fur;

class Constrains extends fur.Constrains{
  late fur.Constrains _constrains;

  setConstrains(fur.Constrains constrains){
    _constrains = constrains;
    return this;
  }

  fur.Constrains getRepository(){
    return _constrains;
  }

  getConstrainsFromRepository(){
    return _constrains;
  }

  List<String>? getGlobalPictureFormats(){
    return _constrains.getGlobalPictureFormats();
  }

  List<String>? getGlobalVideoFormats(){
    return _constrains.getGlobalVideoFormats();
  }

  double? getGlobalPictureMinSize(){
    return _constrains.getGlobalPictureMinSize();
  }

  double? getGlobalPictureMaxSize(){
    return _constrains.getGlobalPictureMaxSize();
  }

  double? getGlobalVideoMinSize(){
    return _constrains.getGlobalVideoMinSize();
  }

  double? getGlobalVideoMaxSize(){
    return _constrains.getGlobalVideoMaxSize();
  }

}