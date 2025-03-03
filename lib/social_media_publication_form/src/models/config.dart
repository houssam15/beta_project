import "package:alpha_flutter_project/social_media_file_uploader_form/social_media_file_uploader_form.dart";

class Config{
  static String _appRoute = "/social_media_publication_upload";
  final String? _nextPageAppRoute = null;
  final String? _prevPageAppRoute = SocialMediaFileUploaderForm.route;

  ///Social media publication form app route (app routing)
  static String get appRoute => _appRoute;
  ///Next page app route
  String? get nextPageAppRoute => _nextPageAppRoute;
  ///Prev page app route
  String? get prevPageAppRoute => _prevPageAppRoute;
}