part of "social_media_publication.dart";


class SocialMediaPublicationDocumentFormat{
    SocialMediaPublicationDocumentFormatType type;
    String url;

    SocialMediaPublicationDocumentFormat({
        required this.type,
        required this.url
    });

    static SocialMediaPublicationDocumentFormat? fromApi(smpa.SocialMediaPublicationDocumentFormat data){
        try{
            return SocialMediaPublicationDocumentFormat(
                type: data.type.toFormatType(),
                url: data.url.toString()
            );
        }catch(err){
            return null;
        }
    }

    static List<SocialMediaPublicationDocumentFormat> toList(List<smpa.SocialMediaPublicationDocumentFormat> data){
        List<SocialMediaPublicationDocumentFormat> items = [];
        for(smpa.SocialMediaPublicationDocumentFormat item in data){
            SocialMediaPublicationDocumentFormat? format;
            try{
                format = SocialMediaPublicationDocumentFormat.fromApi(item);
            }catch(err){
                //Ignore invalid format type
            }
            if(format != null) items.add(format);
        }
        //Formats should include original format , else document should be ignored
        if(!items.any((format) => format.type == SocialMediaPublicationDocumentFormatType.original)) throw Exception("Invalid document is invalid");

        return items;
    }
}