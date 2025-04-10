part of "social_media_publication.dart";

class SocialMediaPublicationDocument{
  String id;
  FileType fileType;
  List<smpr.SocialMediaPublicationDocumentFormat> formats;
  SocialMediaPublicationNetworkDocumentAccount? account;

  SocialMediaPublicationDocument({
    required this.id,
    required this.fileType,
    required this.formats,
    required this.account
  });
}