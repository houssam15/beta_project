part of "social_media_list_form.remote.bloc.dart";

enum SocialMediaListFormRemoteStatus {
  initial,
  loadingSocialMedia,
  socialMediaLoaded,
  socialMediaFailed
}
class SocialMediaListFormRemoteState extends Equatable{

  SocialMediaListFormRemoteState({
    this.status = SocialMediaListFormRemoteStatus.initial,
    this.socialMediaItems = const [],
    this.message = "",
    this.enableNextAction = false
  });


  SocialMediaListFormRemoteStatus status;
  List<SocialMediaItem> socialMediaItems;
  String message;
  bool enableNextAction;

  SocialMediaListFormRemoteState copyWith({
    SocialMediaListFormRemoteStatus? status,
    List<SocialMediaItem>? socialMediaItems,
    String? message,
    bool? enableNextAction
  }){
    return SocialMediaListFormRemoteState(
      status: status??this.status,
      socialMediaItems: socialMediaItems??this.socialMediaItems,
      message: message??this.message,
      enableNextAction: enableNextAction??this.enableNextAction
    );
 }

 bool isSocialListItemsChecked(){
    for(SocialMediaItem item in socialMediaItems){
      if(item.isSelected) return true;
    }
    return false;
 }

  @override
  List<Object?> get props => [status,socialMediaItems,message,enableNextAction];

}