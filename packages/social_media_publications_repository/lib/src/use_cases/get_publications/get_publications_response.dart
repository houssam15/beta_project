import "../../models/models.dart";

class GetPublicationsResponse {
  List<SocialMediaPublication> _publications;
  String? _errorMessage;
  List<SocialMediaPublicationWithError> _invalidPublications;
  GetPublicationsResponse()
  :_publications = []
  ,_invalidPublications = [];

  GetPublicationsResponse setErrorMessage(String err){
    _errorMessage = err;
    return this;
  }

  String? getErrorMessage(){
    return _errorMessage;
  }

  bool isValid(){
    return _errorMessage == null;
  }

  List<SocialMediaPublication> getPublications(){
    return _publications;
  }

  GetPublicationsResponse setPublications(List<SocialMediaPublication> publications){
    _publications = publications;
    return this;
  }

  List<SocialMediaPublicationWithError> getInvalidPublications(){
    return _invalidPublications;
  }

  GetPublicationsResponse setInvalidPublications(List<SocialMediaPublicationWithError> publications){
    _invalidPublications = publications;
    return this;
  }
}