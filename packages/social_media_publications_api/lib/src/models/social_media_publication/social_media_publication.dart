import 'package:social_media_publications_api/src/models/social_media_publication/social_media_publication_document.dart';
import 'package:social_media_publications_api/src/validation/social_media_publication_validation.dart';

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
  //Helpers
  SocialMediaPublicationValidation _validator;
  List<String> _errors;

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
  })
  :_validator = SocialMediaPublicationValidation()
  ,_errors = [];

  SocialMediaPublicationValidation getValidator(){
    return _validator;
  }

  List<String> getErrors(){
    return _errors;
  }

  List<SocialMediaPublication> toList(dynamic data){
    List<SocialMediaPublication> items = [];
    try{
      if(data["error"] != null){
        _errors = [data["error"]];
      }else if(data["errors"] != null){
        for(dynamic elm in data["errors"].entries){
            _errors.add(elm.value);
        }
      }else{
        for(dynamic item in data["items"]){
          SocialMediaPublication? publication = fromJson(item);
          if(publication != null) items.add(publication);
        }
      }
    }catch(err){
      _errors = [err.toString()];
    }
    if(_errors.isNotEmpty) throw Exception();
    return items;
  }

  SocialMediaPublication? fromJson(data){
    try{
      return SocialMediaPublication(
          id: data["id"].toString(),
          datedAt: data["dated_at"].toString(),
          createdAt: data["created_at"].toString(),
          title: data["title"].toString(),
          description: data['description'].toString(),
          state: data["state"].toString(),
          status: data['status'].toString(),
          document: SocialMediaPublicationDocument().fromJson(data["document"]),
          documents: SocialMediaPublicationDocument().toList(data["documents"])
      );
    }catch(err){
      return null;
    }
  }


}