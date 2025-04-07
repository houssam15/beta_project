class UpdatePublicationRequest{
  final String? publicationId;
  final String? title;
  final String? description;
  final String? datedAt;

  UpdatePublicationRequest._({this.publicationId,this.title,this.description,this.datedAt});


  static UpdatePublicationRequest create({String? publicationId,String? title,String? description,String? datedAt}) {
    return UpdatePublicationRequest._(publicationId: publicationId,title: title,description: description,datedAt: datedAt);
  }

}