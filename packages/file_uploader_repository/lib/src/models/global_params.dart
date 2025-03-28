import 'package:equatable/equatable.dart';

class GlobalParams extends Equatable{
  final String fileChunkedUploadBaseUrl;
  final String? fileChunkedUploadPath;
  final int? fileChunkedUploadMaxChunkSize;
  final String? fileChunkedUploadContentType;
  final String? fileChunkedUploadAuthorizationToken;
  GlobalParams({
    required this.fileChunkedUploadBaseUrl,
    this.fileChunkedUploadContentType,
    this.fileChunkedUploadMaxChunkSize,
    this.fileChunkedUploadPath,
    this.fileChunkedUploadAuthorizationToken
  });

  @override
  List<Object?> get props => [fileChunkedUploadBaseUrl,fileChunkedUploadPath,fileChunkedUploadMaxChunkSize,fileChunkedUploadContentType,fileChunkedUploadAuthorizationToken];
}