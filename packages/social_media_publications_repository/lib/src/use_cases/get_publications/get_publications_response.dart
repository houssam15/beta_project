import "../../models/models.dart";

class GetPublicationsResponse {
  List<SocialMediaPublication> _publications;
  String? _errorMessage;
  List<SocialMediaPublicationWithError> _invalidPublications;
  int _totalItems;
  int _totalItemsByPage;
  List<SocialMediaPublicationNetworkDocumentAccount> _accounts;
  GetPublicationsResponse()
  :_publications = []
  ,_invalidPublications = []
  ,_totalItems = 0
  ,_totalItemsByPage = 0
  ,_accounts=[
    SocialMediaPublicationNetworkDocumentAccount(id: "1",name: "Facebook",engine: SocialMediaPublicationNetworkDocumentAccountEngine.facebook),
    SocialMediaPublicationNetworkDocumentAccount(id: "2",name: "Instagram",engine: SocialMediaPublicationNetworkDocumentAccountEngine.instagram),
    SocialMediaPublicationNetworkDocumentAccount(id: "3",name: "google",engine: SocialMediaPublicationNetworkDocumentAccountEngine.google),
    SocialMediaPublicationNetworkDocumentAccount(id: "4",name: "linkedin",engine: SocialMediaPublicationNetworkDocumentAccountEngine.linkedin),
    SocialMediaPublicationNetworkDocumentAccount(id: "5",name: "linkedin",engine: SocialMediaPublicationNetworkDocumentAccountEngine.linkedin),
    SocialMediaPublicationNetworkDocumentAccount(id: "6",name: "linkedin",engine: SocialMediaPublicationNetworkDocumentAccountEngine.linkedin),
    SocialMediaPublicationNetworkDocumentAccount(id: "7",name: "linkedin",engine: SocialMediaPublicationNetworkDocumentAccountEngine.linkedin)

  ];

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

  List<SocialMediaPublicationNetworkDocumentAccount> getAccounts(){
    return _accounts;
  }
}