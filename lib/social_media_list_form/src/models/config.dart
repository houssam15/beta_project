part of 'models.dart';

class Config{
  static String appRoute = "/social_media_list_form";
  final String? nextPageAppRoute = null;
  final String? prevPageAppRoute = SocialMediaPublicationForm.route;
  static String featureName = "social_media_list_form";
  static String authorizationToken = "oula1nk8s3uos2t52oeh5uquc5";
  static final String baseUrl = "https://bridge.ewebsolutionskech-dev.com";
  static final String mediaLargeFileUploadForPublicationEndpoint = "/api/mob/customers/socialnetwork/manager/admin/UploadPublicationDocumentForPublication";
  static final String mediaLargeFileUploadEndpoint = "/api/mob/customers/socialnetwork/manager/admin/UploadDocumentForNewPublication";
}