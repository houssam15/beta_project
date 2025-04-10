part of "social_media_publication.dart";

class SocialMediaPublicationDocument{
  //Shared between original document and network specific document
  String id;
  SocialMediaPublicationDocumentFileType fileType;
  List<SocialMediaPublicationDocumentFormat> formats;
  //only for network specific document
  SocialMediaPublicationNetworkDocumentAccount? account;
  SocialMediaPublicationNetworkEngineState engineState;


  SocialMediaPublicationDocument({
    required this.id,
    required this.fileType,
    this.formats = const [],
    this.account,
    required this.engineState
  });

  static SocialMediaPublicationDocument fromApi(smpa.SocialMediaPublicationDocument data){
    try{
      return SocialMediaPublicationDocument(
          id: data.id.toString(),
          fileType: data.fileType.toFileType(),
          formats: SocialMediaPublicationDocumentFormat.toList(data.formats),
          account: data.account == null ? null : SocialMediaPublicationNetworkDocumentAccount.fromApi(data.account!),
          engineState: data.account == null ? SocialMediaPublicationNetworkEngineState.noStateForOriginDocument : data.getEngineState()
      );
    }catch(err){
      rethrow;
    }
  }

  static List<SocialMediaPublicationDocument> fromList(List<smpa.SocialMediaPublicationDocument> data) {
    List<SocialMediaPublicationDocument> items = [];
    for(smpa.SocialMediaPublicationDocument item in data){
      SocialMediaPublicationDocument? doc;
      try{
        doc = SocialMediaPublicationDocument.fromApi(item);
        //if account is invalid document should be ignored
        if(doc.account == null && doc.engineState != SocialMediaPublicationNetworkEngineState.noStateForOriginDocument){
          throw Exception("Account should not be empty for network document");
        }

        items.add(doc);
      }catch(err){
        //Invalid documents should be ignored
      }

    }
    return items;
  }

}