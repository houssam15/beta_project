class FileParams{

  final RequestOptions fileRequestOptions;

  FileParams({required this.fileRequestOptions});
}


class RequestOptions{
  final String method;
  final String baseUrl;

  RequestOptions({
    required this.method,
    required this.baseUrl
  });
}
