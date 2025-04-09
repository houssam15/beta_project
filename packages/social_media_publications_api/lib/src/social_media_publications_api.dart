import "package:common/common.dart";
import "package:dio/dio.dart";
import "package:social_media_publications_api/src/models/models.dart";
class SocialMediaPublicationsApi{
  SocialMediaPublicationsApi({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<DataState<List<SocialMediaPublication>>> getPublications(Map<String,dynamic> params) async{
    SocialMediaPublication _publication = SocialMediaPublication();
    try{
      Response response = await _dio.get("https://bridge.ewebsolutionskech-dev.com//api/mob/customers/socialnetwork/manager/admin/ListPublication",options: Options(
          headers: {
            "Authorization":"Bearer 0kaibvma8vdlv3ilpjsflheq86"
          }
      ));

      if (response.statusCode != 200) {
        return DataFailed('Failed to fetch file',details: response);
      }else if(!_publication.getValidator().validate(response.data).isValid()){
        return DataFailed('Invalid data received from server',details:_publication.getValidator().getErrors());
      }else{
        List<SocialMediaPublication> publications = _publication.toList(response.data);
        return DataSuccess(publications);
      }
    }catch(err){
      return DataFailed("Can't get publications",details: _publication.getErrors());
    }
  }
}