import "models.dart";
class SocialMediaItemError{
  final String? errorType;
  final List<String>? messages;
  final ValidConstraints? validConstraints;

  SocialMediaItemError({
    this.errorType,
    this.messages,
    this.validConstraints
  });

  static SocialMediaItemError? fromJson(dynamic data){
    try{
      return SocialMediaItemError(
          errorType: data.errorType,
          messages: data.messages,
          validConstraints: ValidConstraints.fromJson(data.validConstraints)
      );
    }catch(err){
      return null;
    }
  }

}