import 'package:alpha_flutter_project/authentication/authentication.dart';
import 'package:alpha_flutter_project/social_media_publication_form/social_media_publication_form.dart';
class Config extends Equatable{
  //File uploader app config
  static String _appRoute = "/file_uploader_app";
  final String? _nextPageAppRoute = SocialMediaPublicationForm.route;
  //Media chunked uploader config
  final String _mediaUploadBaseUrl = "https://bridge.ewebsolutionskech-dev.com";
  final String _mediaLargeFileUploadEndpoint = "/api/mob/customers/socialnetwork/manager/admin/UploadDocumentForNewPublication";
  final List<String> _supportedExtensions = ["png","jpeg","gif","mp4"];
  final String _authorizationToken = "oula1nk8s3uos2t52oeh5uquc5";
  ///File uploader route for internal app routing purpose
  static String get appRoute => _appRoute;

  ///Next page app route
  String? get nextPageAppRoute => _nextPageAppRoute;

  ///Get base url for server that manage large file upload
  String get mediaUploadBaseUrl => _mediaUploadBaseUrl;

  ///Get endpoint for controller that manage large file chunks
  String get mediaLargeFileUploadEndpoint => _mediaLargeFileUploadEndpoint;

  ///Get supported file extensions to upload
  List<String> get supportedExtensions => _supportedExtensions;

  ///Get bearer token
  String get authorizationToken => _authorizationToken;
  @override
  List<Object?> get props => [_mediaUploadBaseUrl,_mediaLargeFileUploadEndpoint,_mediaLargeFileUploadEndpoint,_supportedExtensions,_authorizationToken];
}