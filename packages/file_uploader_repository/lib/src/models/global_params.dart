import 'package:equatable/equatable.dart';

class GlobalParams extends Equatable{
  final String fileChunkedUploadBaseUrl;
  final String? fileChunkedUploadPath;
  final int? fileChunkedUploadMaxChunkSize;
  final String? fileChunkedUploadContentType;

  GlobalParams({
    required this.fileChunkedUploadBaseUrl,
    this.fileChunkedUploadContentType,
    this.fileChunkedUploadMaxChunkSize,
    this.fileChunkedUploadPath
  });

  @override
  List<Object?> get props => [fileChunkedUploadBaseUrl,fileChunkedUploadPath,fileChunkedUploadMaxChunkSize,fileChunkedUploadContentType];
}