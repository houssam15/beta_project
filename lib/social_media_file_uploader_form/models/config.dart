import 'package:alpha_flutter_project/authentication/authentication.dart';
import 'package:alpha_flutter_project/social_media_publication_form/social_media_publication_form.dart';
class Config extends Equatable{
  //File uploader app config
  static String appRoute = "/file_uploader_app";
  static String? nextPageAppRoute = SocialMediaPublicationForm.route;
  //Media chunked uploader config
  static  String mediaUploadBaseUrl = "https://bridge.ewebsolutionskech-dev.com";
  static  String mediaLargeFileUploadEndpoint = "/api/mob/customers/socialnetwork/manager/admin/UploadDocumentForNewPublication";
  static String mediaLargeFileUploadForNetworkEndpoint = "/api/mob/customers/socialnetwork/manager/admin/UploadPublicationDocumentForPublication";
  static  List<String> supportedExtensions = ["png","jpeg","gif","mp4"];
  static  String authorizationToken = "oula1nk8s3uos2t52oeh5uquc5";

  @override
  List<Object?> get props => [mediaUploadBaseUrl,mediaLargeFileUploadEndpoint,mediaLargeFileUploadEndpoint,supportedExtensions,authorizationToken];
}