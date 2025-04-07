import "package:alpha_flutter_project/common/common.dart";
import "package:file_uploader_repository/file_uploader_repository.dart" as fur;
import "../src/models/models.dart";

class SocialMediaPublicationFormArguments implements FeatureParams<SocialMediaPublicationFormArguments>{
    final String appBarTitle;
    final UploadDocumentResponse? uploadDocumentResponse;
    dynamic mediaType;
    dynamic constrains;
    dynamic currentState;
    SocialMediaPublicationFormArguments({
      this.appBarTitle = "Publication details",
      fur.UploadDocumentResponse? uploadDocumentResponse,
      this.mediaType,
      this.constrains,
      this.currentState
    }) : uploadDocumentResponse = UploadDocumentResponse.create(uploadDocumentResponse);

    SocialMediaPublicationFormArguments fromJson(dynamic args) {
        return SocialMediaPublicationFormArguments(
          appBarTitle: args?.appbarTitle??this.appBarTitle
        );
    }

  @override
  SocialMediaPublicationFormArguments create([params]) {
    return SocialMediaPublicationFormArguments();
  }

  @override
  bool isValid() {
    return this.uploadDocumentResponse != null && this.uploadDocumentResponse?.getRepository() != null;
  }
}