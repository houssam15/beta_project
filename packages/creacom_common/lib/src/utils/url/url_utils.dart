import "package:flutter/foundation.dart";

class UrlUtils {
  static String? addQueryParamsToUrl(String? url,[Map<String,dynamic>? extraQueryParams]){
    try{
      if(url==null) throw ArgumentError("Can't encode invalid urls (url = $url)");
      //Throw FormatException if url not in valid format
      Uri uri = Uri.parse(url);
      if(extraQueryParams==null || extraQueryParams.isEmpty) return url;
      return uri.replace(
          queryParameters: {
            ...uri.queryParameters,
            ...extraQueryParams.map((k, v) => MapEntry(k, v?.toString()))//Ensure extraQueryParams is Map<String,String>
          }
      ).toString();
    }on FormatException catch(e){
      debugPrint("Invalid URL format: $e");
      return null;
    }on ArgumentError catch(e){
      debugPrint("Argument error: $e");
      rethrow; // Let critical errors propagate
    }catch(e){
      debugPrint("Unexpected error: $e");
      return null;
    }
  }
}