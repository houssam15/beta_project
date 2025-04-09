import 'social_media_publication_network_document_account.dart';
import 'social_media_publication_document_format.dart';

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
    this.isValid = false
  });

}