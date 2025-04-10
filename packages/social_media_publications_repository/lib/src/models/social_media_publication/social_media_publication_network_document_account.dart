part of "social_media_publication.dart";

class SocialMediaPublicationNetworkDocumentAccount {
  String id;
  String name;
  SocialMediaPublicationNetworkDocumentAccountEngine engine;

  SocialMediaPublicationNetworkDocumentAccount({
    required this.id,
    required this.name,
    required this.engine
  });

  static SocialMediaPublicationNetworkDocumentAccount? fromApi(smpa.SocialMediaPublicationNetworkDocumentAccount data){
    try{
      return SocialMediaPublicationNetworkDocumentAccount(
          id: data.id.toString(),
          name: data.name.toString(),
          engine: data.engine.toEngineType()
      );
    }catch(err){
      return null;
    }
  }

}