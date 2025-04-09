import 'package:social_media_publications_api/social_media_publications_api.dart';
import 'package:social_media_publications_repository/src/use_cases/get_publications/get_publications_request.dart';
import 'package:social_media_publications_repository/src/use_cases/get_publications/get_publications_response.dart';
import 'package:social_media_publications_repository/src/use_cases/get_publications/get_publications_use_case.dart';

class SocialMediaPublicationsRepository {
  //Initialize Social media publications api
  SocialMediaPublicationsApi _api;

  SocialMediaPublicationsRepository()
  :_api = SocialMediaPublicationsApi();

  ///Get publications list
  Future<GetPublicationsResponse> getPublications(GetPublicationsRequest request) async {
    return GetPublicationsUseCase().setApi(_api).call(request);
  }
}