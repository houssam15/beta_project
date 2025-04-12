import "../../models/models.dart";

class GetPublicationsResponse {
  List<SocialMediaPublication> _publications;
  String? _errorMessage;
  List<SocialMediaPublicationWithError> _invalidPublications;
  int _totalItems;
  int _totalItemsByPage;

  GetPublicationsResponse()
  :_publications = []
  ,_invalidPublications = []
  ,_totalItems = 0
  ,_totalItemsByPage = 0;

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

  GetPublicationsResponse setTotalPublications(int total){
    _totalItems = total;
    return this;
  }

  int getTotalPublications(){
    return _totalItems;
  }

  GetPublicationsResponse setTotalPublicationsByPage(int total){
    _totalItemsByPage = total;
    return this;
  }

  int getTotalItemsByPage(){
    return _totalItemsByPage;
  }

  int getTotalOfInvalidPublications(){
    return _invalidPublications.length;
  }
}