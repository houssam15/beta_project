part of 'models.dart';

class Config extends Equatable{
  static String _appRoute = "/social_media_list_form";
  final String? _nextPageAppRoute = null;
  final String? _prevPageAppRoute = SocialMediaPublicationForm.route;
  static String _featureName = "social_media_list_form";

  ///Social media publication form app route (app routing)
  static String get appRoute => _appRoute;
  ///Next page app route
  String? get nextPageAppRoute => _nextPageAppRoute;
  ///Prev page app route
  String? get prevPageAppRoute => _prevPageAppRoute;
  ///Feature name
  static String get featureName => _featureName;

  @override
  List<Object?> get props => [_appRoute,_nextPageAppRoute,_prevPageAppRoute];
}