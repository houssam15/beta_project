part of "config.dart";
class SocialMediaPublicationListParams implements FeatureParams<SocialMediaPublicationListParams>{

  @override
  SocialMediaPublicationListParams create([dynamic params]){
    if (params == null) {
      return SocialMediaPublicationListParams();
    } else {
      return params as SocialMediaPublicationListParams;
    }
  }

  @override
  bool isValid() {
    return true;
  }

}