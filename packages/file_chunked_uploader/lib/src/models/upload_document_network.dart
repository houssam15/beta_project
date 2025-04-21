import 'package:equatable/equatable.dart';

class UploadDocumentNetwork extends Equatable {
  final String id;
  final String engine;
  final String name;
  final bool isResizeRequired;
  final bool isUndersized;
  final bool isRatioUndersized;
  final String ratio;
  final List<String> messages;

  UploadDocumentNetwork({
    required this.id,
    required this.engine,
    required this.name,
    required this.isResizeRequired,
    required this.isUndersized,
    required this.isRatioUndersized,
    required this.ratio,
    required this.messages
  });

  static UploadDocumentNetwork fromJson(data){
    try{
        return UploadDocumentNetwork(
            id: data["id"].toString(),
            name: (data["name"] ?? "").toString(),
            engine: data["engine"].toString(),
            isResizeRequired: data["is_resized_required"],
            isUndersized: data["is_undersized"],
            isRatioUndersized: data["is_ratio_undersized"],
            ratio: data["ratio"].toString(),
            messages: data["messages"]?.map<String>((elm)=>elm.toString()).toList()??[]
        );
    }catch(err){
      rethrow;
    }
  }

  bool isExist(){
    return messages.isNotEmpty;
  }

  @override
  List<Object?> get props => [id,engine,isResizeRequired,isUndersized,isRatioUndersized,ratio,messages];
}