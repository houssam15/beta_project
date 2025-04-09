import 'package:alpha_flutter_project/common/common.dart';
import 'package:alpha_flutter_project/social_media_list_form/src/bloc/remote/social_media_list_form.remote.bloc.dart';
import 'package:localization_service/localization_service.dart';
import "package:file_uploader_repository/file_uploader_repository.dart" as fur;
import 'models/models.dart';
class SocialMediaListFormArguments implements FeatureParams<SocialMediaListFormArguments>{
  /// Show the HomeLayout AppBar , set to false to avoid have two AppBars in same page
  final String appBarTitle;
  final UploadDocumentResponse? uploadDocumentResponse;
  final Constrains? constrains;
  final MediaType mediaType;
  final dynamic previousState;
  SocialMediaListFormArguments({
    String? mediaType,
    String? appBarTitle,
    fur.UploadDocumentResponse? uploadDocumentResponse,
    fur.Constrains? constrains,
    this.previousState
  }) : appBarTitle = appBarTitle ?? LocalizationService.tr("Social media list"),
       uploadDocumentResponse = UploadDocumentResponse.create(uploadDocumentResponse),
       constrains = Constrains.create(constrains),
       mediaType = mediaType == MediaType.picture.toString() ? MediaType.picture:MediaType.video;

  @override
  SocialMediaListFormArguments create([params]) {
    return SocialMediaListFormArguments(mediaType: "");
  }

  @override
  bool isValid() {
    return this.uploadDocumentResponse != null && this.uploadDocumentResponse?.getRepository() != null;
  }

}