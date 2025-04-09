/*import "package:flutter/cupertino.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:file_chunked_uploader/file_chunked_uploader.dart" as fcu;
import "upload_document_response_warning.dart";
class UploadDocumentResponseWarning {
  final List<String> globalMessages;
  final List<UploadDocumentResponseWarning> networks;

  UploadDocumentResponseWarning({
    this.globalMessages = const [],
    this.networks = const []
  });

  static UploadDocumentResponseWarning? fromApi(file_chunked_uploader.UploadDocumentWarning? validation){
    return validation != null ?UploadDocumentResponseWarning(
       globalMessages: validation.messages,
       networks: validation.networks.map<UploadDocumentResponseWarning>(
               (elm)=>UploadDocumentResponseWarning(name:elm.engine,typeIcon: UploadDocumentResponseWarning().getIconByKey(elm.engine.toLowerCase()), messages: elm.messages)
       ).toList()
    ):null;
  }

  List<String> getGlobalMessages(){
    return globalMessages;
  }

  List<UploadDocumentResponseWarningForNetwork> getMessagesGroupedByNetwork(){
    return networks;
  }

  IconData getIconByKey(String key){
    final icons = {
      "facebook":FontAwesomeIcons.facebook,
      "instagram":FontAwesomeIcons.instagram,
      "linkedin":FontAwesomeIcons.linkedin,
      "default":FontAwesomeIcons.circleInfo
    };
    return icons[key] ?? icons["default"]!;
  }

}
*/