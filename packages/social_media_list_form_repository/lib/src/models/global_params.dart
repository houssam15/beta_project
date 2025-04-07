import 'package:equatable/equatable.dart';

class GlobalParams{
  final String? baseUrl;
  final String? authorizationToken;
  final String? fileChunkedUploadPath;
  final int? fileChunkedUploadMaxChunkSize;
  final String? fileChunkedUploadContentType;
  final String? updateDocumentEndpoint;
  GlobalParams({
    this.baseUrl,
    this.fileChunkedUploadContentType,
    this.fileChunkedUploadMaxChunkSize,
    this.fileChunkedUploadPath,
    this.authorizationToken,
    this.updateDocumentEndpoint,
  });

}