import "package:social_media_publications_api/social_media_publications_api.dart" as smpa;

class GetPublicationsRequest {
  final int page;
  GetPublicationsRequest({
    this.page = 1
  });

  smpa.GetPublicationsRequest toApiParams(){
    return smpa.GetPublicationsRequest(
      page: page
    );
  }


}