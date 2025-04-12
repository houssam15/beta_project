import "dart:core";

import "package:social_media_publications_api/social_media_publications_api.dart" as smpa;

part "social_media_publication_document.dart";
part 'social_media_publication_document_format.dart';
part 'social_media_publication_network_document_account.dart';

enum SocialMediaPublicationState {
  published , publishAt , inProgress
}

enum SocialMediaPublicationDocumentFileType{
  picture,video
}

enum SocialMediaPublicationNetworkEngineState {
  valid, invalid, loading, noStateForOriginDocument
}

enum SocialMediaPublicationDocumentFormatType{
  original,small,medium,thumb
}

enum SocialMediaPublicationNetworkDocumentAccountEngine{
  facebook,instagram,linkedin,google
}

extension StringMapping on String?{
  SocialMediaPublicationState toState(){
    switch (this){
      case "inprogress": return  SocialMediaPublicationState.inProgress;
      case "published" : return SocialMediaPublicationState.published;
      case "publish" : return SocialMediaPublicationState.publishAt;
      default : return SocialMediaPublicationState.inProgress; // if state is invalid , publication stay in progress intel it's valid
    }
  }

  SocialMediaPublicationDocumentFileType toFileType(){
    switch(this){
      case "picture" : return SocialMediaPublicationDocumentFileType.picture;
      case "video" : return SocialMediaPublicationDocumentFileType.video;
      default : throw Exception("Unknown file type"); // if file type unknown publication will ignored from list
    }
  }

  SocialMediaPublicationDocumentFormatType toFormatType(){
    switch(this){
      case "original" : return SocialMediaPublicationDocumentFormatType.original;
      case "small" : return SocialMediaPublicationDocumentFormatType.small;
      case "medium" : return SocialMediaPublicationDocumentFormatType.medium;
      case "thumb" : return SocialMediaPublicationDocumentFormatType.thumb;
      default : throw Exception("Unknown format type"); // if format type unknown format will ignored from formats document publication list
    }
  }

  SocialMediaPublicationNetworkDocumentAccountEngine toEngineType(){
    switch(this){
      case "Facebook" : return SocialMediaPublicationNetworkDocumentAccountEngine.facebook;
      case "Instagram" : return SocialMediaPublicationNetworkDocumentAccountEngine.instagram;
      case "Linkedin" : return SocialMediaPublicationNetworkDocumentAccountEngine.linkedin;
      case "Google" : return SocialMediaPublicationNetworkDocumentAccountEngine.google;
      default : throw Exception("Unknown Engine");//if engine unknown , the network document should be ignored
    }
  }
}

extension SocialMediaPublicationDocumentApiMapping on smpa.SocialMediaPublicationDocument {
  SocialMediaPublicationNetworkEngineState getEngineState(){
    if(isValid==true && isWorking == true){
      return SocialMediaPublicationNetworkEngineState.loading;
    }else if(isValid == false && isWorking == false){
      return SocialMediaPublicationNetworkEngineState.invalid;
    }else if(isValid == true && isWorking == false){
      return SocialMediaPublicationNetworkEngineState.valid;
    }else {//isValid == false && isWorking == true
      return SocialMediaPublicationNetworkEngineState.loading;
    }
  }
}
class SocialMediaPublicationWithError{
  smpa.SocialMediaPublication item;
  dynamic error;

  SocialMediaPublicationWithError(this.error,this.item);
}

class SocialMediaPublication{
  //Attributes
  String id;
  DateTime? datedAt;
  DateTime createdAt;
  String? title;
  String? description;
  SocialMediaPublicationState state;
  SocialMediaPublicationDocument document;
  List<SocialMediaPublicationDocument> documents;
  bool modifiable;

  //helpers attributes
  static List<SocialMediaPublicationWithError>? _invalidItems;

  static List<SocialMediaPublicationWithError> addInvalidItem(SocialMediaPublicationWithError error){
    _invalidItems ??= []; // Initialize if null
    //final exists = _invalidItems!.any((data) => data.item.id == error.item.id);
    //if (!exists) {
      _invalidItems!.add(error);
    //}
    return _invalidItems!;
  }

  static List<SocialMediaPublicationWithError> getInvalidItems(){
    return _invalidItems ?? [];
  }

  //Initialization
  SocialMediaPublication({
    required this.id,
    this.datedAt,
    required this.createdAt,
    this.title,
    this.description,
    required this.state,
    required this.document,
    this.documents = const [],
    required this.modifiable
  });


  static SocialMediaPublication? fromApi(smpa.SocialMediaPublication data){
    try{
      return SocialMediaPublication(
          id: data.id.toString(),
          datedAt: data.datedAt == null ? null : DateTime.parse(data.datedAt.toString()),
          createdAt: DateTime.parse(data.createdAt.toString()),
          title: data.title,
          description: data.description,
          state: data.state.toState(),
          document:data.document == null ? throw Exception("Publication should have a document") : SocialMediaPublicationDocument.fromApi(data.document!),
          documents: SocialMediaPublicationDocument.fromList(data.documents),
          modifiable: data.state.toState() == SocialMediaPublicationState.inProgress
      );
    }catch(err){
      SocialMediaPublication.addInvalidItem(SocialMediaPublicationWithError(err, data));
      return null;
    }
  }

  static List<SocialMediaPublication> toList(List<smpa.SocialMediaPublication> data){
    List<SocialMediaPublication> items = [];
    for(smpa.SocialMediaPublication item in data){
      SocialMediaPublication? pub = SocialMediaPublication.fromApi(item);
      if(pub!=null) items.add(pub);
    }
    return items;
  }

}