import "social_media_publication_document.dart";

class SocialMediaPublication{
  //Attributes
  String? id;
  String? datedAt;
  String? createdAt;
  String? title;
  String? description;
  String? state;
  String? status;
  SocialMediaPublicationDocument? document;
  List<SocialMediaPublicationDocument> documents;


  //Initialization
  SocialMediaPublication({
    this.id,
    this.datedAt,
    this.createdAt,
    this.title,
    this.description,
    this.state,
    this.status,
    this.document,
    this.documents = const []
  });

}