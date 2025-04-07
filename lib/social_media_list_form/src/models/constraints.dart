part of 'models.dart';

class Constrains extends fur.Constrains{
  fur.Constrains? _constrains;

  // Private constructor to prevent direct instantiation
  Constrains._(this._constrains);

  // Factory method with default repository
  static Constrains create(fur.Constrains? constrains) {
    return Constrains._(constrains);
  }

  fur.Constrains? getRepository(){
    return _constrains;
  }


  getConstraintByMediaTypeAndEngine(String? engine,MediaType mediaType){
    print(_constrains?.getPictureConstraintByEngine(engine));
    if(mediaType == MediaType.picture){
      return _constrains?.getPictureConstraintByEngine(engine);
    }else{
      return null;
    }
  }
}