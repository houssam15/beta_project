import "package:dio/dio.dart";

class BaseApi {
  final Dio _dio;

  BaseApi({Dio? dio}) : _dio = dio ?? Dio();

  ///Return dio instance
  Dio getApi(){
    return _dio;
  }

}