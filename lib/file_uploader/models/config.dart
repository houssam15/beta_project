import 'package:alpha_flutter_project/authentication/authentication.dart';
import 'package:alpha_flutter_project/social_media_publication_form/social_media_publication_form.dart';
class Config extends Equatable{
  //File uploader app config
  static String _fileUploaderAppRoute = "/file_uploader_app";
  final String? _nextPageAppRoute = SocialMediaPublicationForm.route;
  //Media chunked uploader config
  final String _mediaUploadBaseUrl = "https://nw72q2b3-3000.uks1.devtunnels.ms/media_uploader";
  final String _mediaLargeFileUploadEndpoint = "/file";
  final List<String> _supportedExtensions = ["png","jpeg","gif","mp4"];

  ///File uploader route for internal app routing purpose
  static String get fileUploaderAppRoute => _fileUploaderAppRoute;

  ///Next page app route
  String? get nextPageAppRoute => _nextPageAppRoute;

  ///Get base url for server that manage large file upload
  String get mediaUploadBaseUrl => _mediaUploadBaseUrl;

  ///Get endpoint for controller that manage large file chunks
  String get mediaLargeFileUploadEndpoint => _mediaLargeFileUploadEndpoint;

  ///Get supported file extensions to upload
  List<String> get supportedExtensions => _supportedExtensions;

  @override
  List<Object?> get props => [_mediaUploadBaseUrl,_mediaLargeFileUploadEndpoint,_mediaLargeFileUploadEndpoint,_supportedExtensions];
}