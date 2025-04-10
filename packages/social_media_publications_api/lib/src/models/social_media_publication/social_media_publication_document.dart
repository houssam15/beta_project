part of "social_media_publication.dart";

class SocialMediaPublicationDocument{
  //Shared between original document and network specific document
  String? id;
  String? height;
  String? width;
  String? extension;
  String? size;
  String? duration;
  String? fileType;
  List<SocialMediaPublicationDocumentFormat> formats;
  //only for network specific document
  SocialMediaPublicationNetworkDocumentAccount? account;
  bool isValid;
  bool isWorking;


  SocialMediaPublicationDocument({
    this.id,
    this.height,
    this.width,
    this.extension,
    this.size,
    this.duration,
    this.fileType,
    this.formats = const [],
    this.account,
    this.isValid = false,
    this.isWorking = false
  });

  SocialMediaPublicationDocument? fromJson(data){
    try{
      String? fileType;

      if(data["file"]?["picture"] != null) fileType = "picture";
      else if(data["file"]?["video"] != null) fileType = "video";
      else fileType = null;

      return SocialMediaPublicationDocument(
        id: data["id"].toString(),
        height: data["height"].toString(),
        width: data["width"].toString(),
        extension: data["extension"].toString(),
        size: data["size"].toString(),
        duration: data["duration"].toString(),
        fileType: fileType,
        formats: fileType == null ? [] : SocialMediaPublicationDocumentFormat().toList(data["file"]?[fileType]),
        account: data["account"] == null ? null : SocialMediaPublicationNetworkDocumentAccount().fromJson(data["account"]),
        isValid: data["is_valid"] == true,
        isWorking: data["is_working"] == true
      );
    }catch(err){
      return null;
    }
  }

  List<SocialMediaPublicationDocument> toList(List<dynamic> data) {
    List<SocialMediaPublicationDocument> items = [];
    for(dynamic item in data){
      SocialMediaPublicationDocument? doc = fromJson(item);
      if(doc != null) items.add(doc);
    }
    return items;
  }
}