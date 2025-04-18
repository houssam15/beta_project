import "package:common/common.dart";
import "package:dio/dio.dart";
import "package:social_media_publications_api/src/models/models.dart";
import "package:social_media_publications_api/src/request/request.dart";
import "package:social_media_publications_api/src/response/response.dart";
import "mock_data/get_publications_mock_data.dart";
class SocialMediaPublicationsApi extends BaseApi{

  Future<DataState<GetPublicationsResponse>> getPublications(GetPublicationsRequest request) async{
    SocialMediaPublication _publication = SocialMediaPublication();
    try{
      Response response = await getApi().post("https://bridge.ewebsolutionskech-dev.com//api/mob/customers/socialnetwork/manager/admin/ListPublication",
          options: Options(
            headers: {
              "Authorization":"Bearer 0kaibvma8vdlv3ilpjsflheq86"
            },
          ),
          data: request.formatDataForApi()
      );

      if (response.statusCode != 200) {
        return DataFailed('Failed to fetch file',details: response);
      }else if(!_publication.getValidator().validate(response.data).isValid()){
        //print(_publication.getValidator().validate(response.data));
        return DataFailed('Invalid data received from server',details:_publication.getValidator().getErrors());
      }else{
        return DataSuccess(GetPublicationsResponse(
          publications: _publication.toList(response.data),
          totalItemByPage: _publication.getErrors().isEmpty ? response.data["number_of_items"] : null,
          totalItems: _publication.getErrors().isEmpty ? response.data["total_of_items"] : null,
          numberOfPages: _publication.getErrors().isEmpty ? response.data["number_of_pages"] : null,
        ));
      }
    }catch(err){
      return DataFailed("Can't get publications",details: _publication.getErrors());
    }
  }
}