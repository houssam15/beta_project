import 'package:equatable/equatable.dart';

class DocumentFormat extends Equatable{
  final String type;
  final String url;

  DocumentFormat({required this.type,required this.url});

  static DocumentFormat fromJson(dynamic data,String? token){
    try {
      return DocumentFormat(type: data["type"], url: "${data["url"]}?token=$token");
    }catch(err){
      rethrow;
    }
  }

  @override
  List<Object?> get props => [type,url];
}