import 'package:equatable/equatable.dart';

///Config file passed to stream function for file chunked upload
class Config extends Equatable{
  ///Server base url
  final String? baseUrl;
  ///Chunk max size to upload to Server , by default is 500000
  int chunkMaxSize;
  ///Path is added to baseUrl in request time
  String path;
  ///Content type header , passed to upload function , by default is 'multipart/form-data'
  String contentType;
  ///Bearer token
  String? authorizationToken;

  Config({
    this.baseUrl,
    int? chunkMaxSize = 500000,
    String? path = "",
    String? contentType = 'multipart/form-data',
    this.authorizationToken
  }):
  chunkMaxSize = chunkMaxSize??500000,
  path = path??"",
  contentType=contentType??'multipart/form-data';

  @override
  List<Object?> get props => [baseUrl,chunkMaxSize,path,authorizationToken];
}