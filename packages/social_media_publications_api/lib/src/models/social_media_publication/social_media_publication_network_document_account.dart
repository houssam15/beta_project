class SocialMediaPublicationNetworkDocumentAccount {
  String? id;
  String? name;
  String? page;
  String? engine;

  SocialMediaPublicationNetworkDocumentAccount({
    this.id,
    this.name,
    this.page,
    this.engine
  });

  SocialMediaPublicationNetworkDocumentAccount? fromJson(data){
    try{
      return SocialMediaPublicationNetworkDocumentAccount(
        id: data["id"].toString(),
        name: data["name"].toString(),
        page: data["page"].toString(),
        engine: data["engine"].toString()
      );
    }catch(err){
      return null;
    }
  }
}