import '../common/common_request.dart';
import "package:social_media_publications_api/social_media_publications_api.dart" as smpa;
class GetPublicationsRequest implements CommonRepositoryRequest<smpa.GetPublicationsRequest>{
  final int page;
  GetPublicationsRequest({
      this.page = 1
  });

  @override
  smpa.GetPublicationsRequest toApiParams() {
    return smpa.GetPublicationsRequest(
      page: page
    );
  }

}