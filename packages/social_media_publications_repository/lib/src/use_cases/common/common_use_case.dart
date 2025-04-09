import 'package:social_media_publications_api/social_media_publications_api.dart';

class CommonUseCase<T> {
  SocialMediaPublicationsApi? _api;

  SocialMediaPublicationsApi getApi(){
    return _api ?? SocialMediaPublicationsApi();
  }

  T setApi(SocialMediaPublicationsApi api){
    _api = api;
    return this as T;
  }

}