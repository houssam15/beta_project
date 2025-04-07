import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media_api/src/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'mock_data/mock_data.dart';

class SocialMediaApi {
  SocialMediaApi({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<DataState<UploadedPicture>> getUploadedPicture({
    required String baseUrl,
    String method = "get",
    String? bearerToken,
    Object? data,
  }) async {
    try {
      Response response = await _dio.request(baseUrl,options: Options(method: method,responseType: ResponseType.bytes,headers: {"Authorization":"Bearer $bearerToken"}),data: data);
      // Check if the response status is 200 OK
      if (response.statusCode == 200) {
        Directory dir = await _getTemporaryDirectory();
        String extension = _extractFileExtensionFromMimeType(response.headers.value('content-type'));
        // Assuming the response data is a file (e.g., binary data)
        final file = File("${dir.path}/${_generateFileName()}.$extension");
        // Provide the file path
        await file.writeAsBytes(response.data);
        return DataSuccess(
            UploadedPicture(file: file,extension: extension.toFileExtension())
        );
      } else {
        return DataFailed('Failed to fetch file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return DataFailed('Error: ${e.toString()}');
    }
  }

  /*Future<DataState<String>> uploadPictureForPublication(File file,{dynamic params}) async {
    try{
      Response response = await _dio.post(
          "${Config.baseUrl}${Config.uploadDocumentForPublicationEndpoint}",
          options: Options(
              headers: {
                "Authorization":"Bearer ${Config.token}"
              }
          ),
          data: data
      );
      await Future.delayed(Duration(seconds: 3));

      return DataSuccess("https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D");
    }catch(err){
      return DataFailed('Error: ${err.toString()}');
    }
  }*/

  Future<DataState<List<SocialMediaItem>>> getSocialMediaList() async {
    try{
      ///TODO : get data from api
      return DataSuccess(SocialMediaItem().fromList(MockData.getSocialMediaListData));
    }catch(err){
      return DataFailed('Error: ${err.toString()}');
    }
  }

  Future<Directory> _getTemporaryDirectory() async{
    return await getTemporaryDirectory();
  }

  String _extractFileExtensionFromMimeType(String? mimeType){
    final fileType = mimeType?.split("/").first;
    if (mimeType == null) throw Exception("mime type not found");
    if(fileType!="image") throw Exception("loaded file is not a valid picture");
    if(mimeType.contains(("jpeg"))) return "jpg";
    else if(mimeType.contains(("png"))) return "png";
    else throw Exception("Unknown file extension");
  }

  String _generateFileName(){
    return Uuid().v4();
  }

  Future<DataState<Constrains>> getConstraints() async {
    try{
      Response response = await _dio.get("${Config.baseUrl}/${Config.getConstraintsEndpoint}",options: Options(
        headers: {
          "Authorization":"Bearer ${Config.token}"
        }
      ));
      if (response.statusCode != 200) {
        return DataFailed('Failed to fetch file. Status code: ${response.statusCode}');
      } else {
        return DataSuccess(Constrains.fromJson(response.data));
        //return DataSuccess(Constrains.fromJson(MockData.getConstraintsMockData[0]));
      }
    }catch(err){
      return DataFailed(err.toString());
    }
  }

  Future<DataState<UpdatePublicationResponse>> updateDocument({String? publicationId,String? title,String? description,String? datedAt}) async {
    try{
      Response response = await _dio.post(
        "${Config.baseUrl}${Config.updateDocumentEndpoint}",
        options: Options(
          headers: {
            "Authorization": "Bearer ${Config.token}",
            "Content-Type": "multipart/form-data"
          },
        ),
        data: FormData.fromMap({
          "publication": publicationId,
          "title": title,
          "description": description,
          "dated_at": datedAt,
        }),
      );
      return DataSuccess(UpdatePublicationResponse.fromJson(response.data));
      //return DataSuccess(UpdatePublicationResponse.fromJson(MockData.updateDocument[0]));
    }on DioException catch(err){
      return DataFailed("Server error !",details: err.toString());
    }
  }
}
