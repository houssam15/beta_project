part of "social_media_list_form.local.bloc.dart";

enum SocialMediaListFormLocalAction {
  none,
  resizeFailed,
  resizeSuccess
}

class SocialMediaListFormLocalState extends Equatable{

  SocialMediaListFormLocalState({
    this.action = SocialMediaListFormLocalAction.none,
    this.message,
    this.socialMediaItem,
    this.random
  });

  SocialMediaListFormLocalAction action;
  String? message;
  SocialMediaItem? socialMediaItem;
  String? random;
  SocialMediaListFormLocalState copyWith({
    SocialMediaListFormLocalAction? action,
    String? message,
    SocialMediaItem? socialMediaItem,
    String? random
  }){
    return SocialMediaListFormLocalState(
      action: action??this.action,
      message: message ?? this.message,
      socialMediaItem: socialMediaItem??this.socialMediaItem,
      random: random ?? this.random
    );
  }

  @override
  List<Object?> get props => [action,message,socialMediaItem,random];
}