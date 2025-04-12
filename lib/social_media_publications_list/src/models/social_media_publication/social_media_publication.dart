import "dart:core";
import "package:alpha_flutter_project/login/login.dart";
import "package:alpha_flutter_project/social_media_publications_list/src/models/social_media_publication/engine_state.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:localization_service/localization_service.dart";
import "package:social_media_publications_repository/social_media_publications_repository.dart" as smpr;
import "formatted_date.dart";
import "publication_text.dart";
import "publication_state.dart";
import "file_type.dart";

part "social_media_publication_document.dart";
part 'social_media_publication_network_document_account.dart';

extension StateMapping on smpr.SocialMediaPublicationState{
  PublicationState toPublicationState(BuildContext context){
    switch(this){
      case smpr.SocialMediaPublicationState.inProgress : return PublicationState.fromRepository((LocalizationService.of(context)?.translate("In progress")).toString(),Colors.orange);
      case smpr.SocialMediaPublicationState.published : return PublicationState.fromRepository((LocalizationService.of(context)?.translate("Published")).toString(),Colors.green);
      case smpr.SocialMediaPublicationState.publishAt : return PublicationState.fromRepository((LocalizationService.of(context)?.translate("Publish")).toString(),Colors.blue);
    }
  }
}

extension FileTypeMapping on smpr.SocialMediaPublicationDocumentFileType{
  IconData getIcon(){
    switch(this){
      case smpr.SocialMediaPublicationDocumentFileType.picture : return FontAwesomeIcons.image;
      case smpr.SocialMediaPublicationDocumentFileType.video : return FontAwesomeIcons.video;
    }
  }
}

extension EngineMapping on smpr.SocialMediaPublicationNetworkDocumentAccountEngine{
  IconData getIcon(){
    switch(this){
      case smpr.SocialMediaPublicationNetworkDocumentAccountEngine.facebook: return FontAwesomeIcons.facebook;
      case smpr.SocialMediaPublicationNetworkDocumentAccountEngine.instagram: return FontAwesomeIcons.instagram;
      case smpr.SocialMediaPublicationNetworkDocumentAccountEngine.linkedin: return FontAwesomeIcons.linkedin;
      case smpr.SocialMediaPublicationNetworkDocumentAccountEngine.google: return FontAwesomeIcons.google;
    }
  }

  Color getColor(){
    switch(this){
      case smpr.SocialMediaPublicationNetworkDocumentAccountEngine.facebook: return Colors.blue;
      case smpr.SocialMediaPublicationNetworkDocumentAccountEngine.instagram: return Colors.pink;
      case smpr.SocialMediaPublicationNetworkDocumentAccountEngine.linkedin: return Colors.lightBlueAccent;
      case smpr.SocialMediaPublicationNetworkDocumentAccountEngine.google: return Colors.red;
    }
  }
}

extension EngineStateMapping on smpr.SocialMediaPublicationNetworkEngineState{
  Color getColor(){
    switch(this){
      case smpr.SocialMediaPublicationNetworkEngineState.valid:return Colors.green;
      case smpr.SocialMediaPublicationNetworkEngineState.invalid:return Colors.red;
      case smpr.SocialMediaPublicationNetworkEngineState.loading:return Colors.grey;
      default : return Colors.transparent;
    }
  }
}

class SocialMediaPublication{
  String id;
  FormattedDate? datedAt;
  FormattedDate createdAt;
  PublicationText title;
  PublicationText description;
  PublicationState state;
  SocialMediaPublicationDocument document;
  List<SocialMediaPublicationDocument> documents;
  bool modifiable;

  //Helpers
  static BuildContext? _context;

  static setContext(BuildContext? context){
    _context = context;
  }

  SocialMediaPublication({
    required this.id,
    required this.datedAt,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.state,
    required this.document,
    required this.documents,
    required this.modifiable
  });

  static List<SocialMediaPublication> toList(List<smpr.SocialMediaPublication> data){
    List<SocialMediaPublication> items = [];
    for(smpr.SocialMediaPublication item in data){
      SocialMediaPublication? pub = SocialMediaPublication.fromRepository(item);
      if(pub!=null)  items.add(pub);
    }
    return items;
  }

  static SocialMediaPublication? fromRepository(smpr.SocialMediaPublication data){
    try{
      if(_context==null) return throw Exception("Invalid context !");
      SocialMediaPublicationDocument? doc = SocialMediaPublicationDocument.fromRepository(data.document);
      if(doc == null) throw Exception("Invalid document");
      return SocialMediaPublication(
        id: data.id,
        datedAt: data.datedAt==null ? null : FormattedDate.fromDateTime(data.datedAt!,context:_context!),
        createdAt: FormattedDate.fromDateTime(data.createdAt,context:_context!),
        title: PublicationText.fromRepository(data.title,context: _context!,label: "title"),
        description: PublicationText.fromRepository(data.description, context: _context!, label: "description"),
        state: data.state.toPublicationState(_context!),
        document: doc,
        documents: SocialMediaPublicationDocument.toList(data.documents),
        modifiable: data.state == smpr.SocialMediaPublicationState.inProgress
      );
    }catch(err){
      return null;
    }
  }

}