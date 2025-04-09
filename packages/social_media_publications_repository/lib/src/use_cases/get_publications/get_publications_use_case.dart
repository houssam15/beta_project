import '../../models/models.dart';
import '../common/common_use_case.dart';
import 'get_publications_request.dart';
import 'get_publications_response.dart';
import "package:common/common.dart";
class GetPublicationsUseCase extends CommonUseCase<GetPublicationsUseCase>{

  Future<GetPublicationsResponse> call(GetPublicationsRequest request) async {
    GetPublicationsResponse response = GetPublicationsResponse();
    final ds = await getApi().getPublications(request.toApiParams());
    if(ds is DataFailed) response.setErrorMessage(ds.error.toString());
    return response.setPublications(SocialMediaPublication().toList(ds.data!));
  }

}