import "dart:core";
import "package:alpha_flutter_project/login/login.dart";
import "package:alpha_flutter_project/social_media_publications_list/src/models/social_media_publication/engine_state.dart";
import "package:social_media_publications_repository/social_media_publications_repository.dart" as smpr;
import "formatted_date.dart";
import "publication_text.dart";
import "publication_state.dart";
import "file_type.dart";

part "social_media_publication_document.dart";
part 'social_media_publication_network_document_account.dart';


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
      return SocialMediaPublication(
        id: data.id,
        datedAt: data.datedAt==null ? null : FormattedDate.fromDateTime(data.datedAt!,context:_context),
        createdAt: FormattedDate.fromDateTime(data.createdAt,context:_context),

      );
    }catch(err){
      return null;
    }
  }

}