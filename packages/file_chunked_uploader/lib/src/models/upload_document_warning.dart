import 'package:equatable/equatable.dart';
import "upload_document_network.dart";
class UploadDocumentWarning extends Equatable{
  final bool isRotationRequired;
  final double realRatio;
  final double height;
  final double width;
  List<String> messages;
  List<UploadDocumentNetwork> networks;

  UploadDocumentWarning({
    required this.isRotationRequired,
    required this.realRatio,
    required this.height,
    required this.width,
    this.messages = const [],
    this.networks = const []
  });

  static UploadDocumentWarning? fromJson(dynamic data){
    try {
      return UploadDocumentWarning(
          isRotationRequired: data["is_rotation_required"],
          realRatio: data["real_ratio"].toDouble(),
          height: data["height"].toDouble(),
          width: data["width"].toDouble(),
          messages: data["messages"]?.map<String>((elm) => elm.toString()).toList() ?? [],
          networks: data["networks"]?.map<UploadDocumentNetwork>((elm) =>UploadDocumentNetwork.fromJson(elm)).toList() ?? []
      );
    }catch(err){
      return null;
    }
  }

  bool isExist(){
    for(UploadDocumentNetwork network in networks){
      if(network.messages.isNotEmpty) return true;
    }
    return messages.isNotEmpty;
  }

  bool isNetworksValid(){
    for(UploadDocumentNetwork network in networks){
      if(
           ((network.isRatioUndersized || network.isResizeRequired || network.isUndersized) && network.messages.isNotEmpty)||
           ((!network.isRatioUndersized && !network.isResizeRequired & !network.isUndersized) && network.messages.isEmpty)
      ) {
        return true;
      }
    }
    return false;
  }

  @override
  List<Object?> get props => [isRotationRequired,realRatio,height,width,messages,networks];
}