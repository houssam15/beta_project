import 'package:social_media_publications_api/social_media_publications_api.dart';

class GetPublicationsResponse{
  List<SocialMediaPublication> publications;
  int totalItems;
  int totalItemByPage;
  int numberOfPages;
  GetPublicationsResponse({
    this.publications = const [],
    this.totalItems = 0,
    this.totalItemByPage = 0,
    this.numberOfPages = 1
  });
}