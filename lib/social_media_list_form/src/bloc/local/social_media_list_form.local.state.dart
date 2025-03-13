part of "social_media_list_form.remote.bloc.dart";

enum SocialMediaListFormRemoteStatus {
  initial,
  loadingSocialMedia,
  socialMediaLoaded,
  socialMediaFailed,
}

enum SocialMediaListFormRemoteActions{
  none,
  itemNeedEdit,
  updateItemStatus,
  updateNextAction,
  switchItemStatus
}

class SocialMediaListFormRemoteState extends Equatable{

  SocialMediaListFormRemoteState({
    this.status = SocialMediaListFormRemoteStatus.initial,
    this.socialMediaItems = const [],
    this.message = "",
    this.enableNextAction = false,
    this.fileId,
    this.action = SocialMediaListFormRemoteActions.none,
    this.itemToEdit
  });


  SocialMediaListFormRemoteStatus status;
  List<SocialMediaItem> socialMediaItems;
  String message;
  bool enableNextAction;
  String? fileId;
  SocialMediaListFormRemoteActions action;
  SocialMediaItem? itemToEdit;

  SocialMediaListFormRemoteState copyWith({
    SocialMediaListFormRemoteStatus? status,
    List<SocialMediaItem>? socialMediaItems,
    String? message,
    bool? enableNextAction,
    String? fileId,
    SocialMediaListFormRemoteActions? action,
    SocialMediaItem? itemToEdit
  }){
    return SocialMediaListFormRemoteState(
      status: status??this.status,
      socialMediaItems: socialMediaItems??this.socialMediaItems,
      message: message??this.message,
      enableNextAction: enableNextAction??this.enableNextAction,
      fileId: fileId??this.fileId,
      action: action??this.action,
      itemToEdit:itemToEdit??this.itemToEdit
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

  @override
  List<Object?> get props => [status,socialMediaItems,message,enableNextAction,fileId,action,itemToEdit];

}