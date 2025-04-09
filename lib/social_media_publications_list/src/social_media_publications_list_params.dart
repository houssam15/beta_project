import "package:alpha_flutter_project/common/common.dart";
import "package:alpha_flutter_project/social_media_common/social_media_common.dart";
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