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

  static SocialMediaPublicationDocument? fromRepository(smpr.SocialMediaPublicationDocument data){
    try{
      return SocialMediaPublicationDocument(
          id: data.id,
          fileType: FileType(type: data.fileType, icon: data.fileType.getIcon()),
          formats: data.formats,
          account: data.account==null
              ? null
              : SocialMediaPublicationNetworkDocumentAccount(
                  icon: data.account!.engine.getIcon(),
                  color: data.account!.engine.getColor(),
                  engineState: EngineState(color: data.engineState.getColor()),
                  twoWordIndicator: data.account?.name==null ? null : data.account?.name.getFirstTwoLetters(),
                  engineType: data.account!.engine
              )
      );
    }catch(err){
      return null;
    }
  }

  static List<SocialMediaPublicationDocument> toList(List<smpr.SocialMediaPublicationDocument> data){
    List<SocialMediaPublicationDocument> items = [];
    for(smpr.SocialMediaPublicationDocument item in data){
      SocialMediaPublicationDocument? doc = fromRepository(item);
      if(doc!=null) items.add(doc);
    }
    return items;
  }
}