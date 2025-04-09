class SocialMediaPublicationDocumentFormat{
    String? type;
    String? url;

    SocialMediaPublicationDocumentFormat({
        this.type,
        this.url
    });

    List<SocialMediaPublicationDocumentFormat> toList(data){
      List<SocialMediaPublicationDocumentFormat> items = [];
      for(dynamic item in data){
        try{
          items.add(SocialMediaPublicationDocumentFormat(type: item["type"],url: item["url"]));
        }catch(err){
          continue;
        }
      }
      return items;

    }
}