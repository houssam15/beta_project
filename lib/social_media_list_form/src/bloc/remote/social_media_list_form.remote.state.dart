part of "social_media_list_form.remote.bloc.dart";

enum SocialMediaListFormRemoteStatus {
  initial,
  loadingSocialMedia,
  socialMediaLoaded,
  socialMediaFailed,

}

enum SocialMediaListFormRemoteActions{
  none,
  updateItemStatus,
  updateNextAction,
  switchItemStatus,
  resizedPictureUploaded,
  resizedPictureUploadedFailed,
  progressForPublication,
  progressForPublicationFailed,
  progressForPublicationSuccess
}

enum MediaType{
  picture,video,none
}

class SocialMediaListFormRemoteState extends Equatable{

  SocialMediaListFormRemoteState({
    this.status = SocialMediaListFormRemoteStatus.initial,
    this.socialMediaItems = const [],
    this.message = "",
    this.enableNextAction = false,
    this.uploadDocumentResponse,
    this.action = SocialMediaListFormRemoteActions.none,
    this.itemToEdit,
    this.mediaType = MediaType.none,
    this.constrains,
    bool isPublishing = false
  }):
  _isPublishing = isPublishing;

  SocialMediaListFormRemoteStatus status;
  List<SocialMediaItem> socialMediaItems;
  String message;
  bool enableNextAction;
  SocialMediaListFormRemoteActions action;
  SocialMediaItem? itemToEdit;
  UploadDocumentResponse? uploadDocumentResponse;
  MediaType mediaType;
  Constrains? constrains;
  bool _isPublishing;

  SocialMediaListFormRemoteState copyWith({
    SocialMediaListFormRemoteStatus? status,
    List<SocialMediaItem>? socialMediaItems,
    String? message,
    bool? enableNextAction,
    UploadDocumentResponse? uploadDocumentResponse,
    SocialMediaListFormRemoteActions? action,
    SocialMediaItem? itemToEdit,
    MediaType? mediaType,
    Constrains? constrains,
    bool? isPublishing
  }){
    return SocialMediaListFormRemoteState(
      status: status??this.status,
      socialMediaItems: socialMediaItems??this.socialMediaItems,
      message: message??this.message,
      enableNextAction: enableNextAction??this.enableNextAction,
      uploadDocumentResponse: uploadDocumentResponse??this.uploadDocumentResponse,
      action: action??this.action,
      itemToEdit:itemToEdit??this.itemToEdit,
      mediaType:  mediaType ?? this.mediaType,
      constrains: constrains ?? this.constrains,
      isPublishing: isPublishing??this._isPublishing
    );
 }

 bool isSocialListItemsChecked(){
    for(SocialMediaItem item in socialMediaItems){
      if(item.isSelected) return true;
    }
    return false;
 }

 SocialMediaItem? getSocialMediaItemByIndex(int index){
   if(socialMediaItems.length-1<index) return null;
   return socialMediaItems[index];
 }

  SocialMediaItem? getItemById(int id){
    return socialMediaItems.toList().firstWhere((element) => element.id == id);
 }

 bool isPublishing() {
    return _isPublishing;
 }


  @override
  List<Object?> get props => [status,socialMediaItems,message,enableNextAction,uploadDocumentResponse,action,itemToEdit,mediaType,isPublishing];

}