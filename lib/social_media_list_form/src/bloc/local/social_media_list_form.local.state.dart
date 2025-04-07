part of "social_media_list_form.local.bloc.dart";

enum SocialMediaListFormLocalAction {
  none,
  resizeFailed,
  resizeSuccess,
  changeFailed,
  changeSuccess
}

class SocialMediaListFormLocalState extends Equatable{

  SocialMediaListFormLocalState({
    this.action = SocialMediaListFormLocalAction.none,
    this.message,
    this.socialMediaItem,
    this.random,
    this.mediaType = MediaType.none,
    this.constrains
  });

  SocialMediaListFormLocalAction action;
  String? message;
  SocialMediaItem? socialMediaItem;
  String? random;
  MediaType mediaType;
  Constrains? constrains;
  SocialMediaListFormLocalState copyWith({
    SocialMediaListFormLocalAction? action,
    String? message,
    SocialMediaItem? socialMediaItem,
    String? random,
    MediaType? mediaType
  }){
    return SocialMediaListFormLocalState(
      action: action??this.action,
      message: message ?? this.message,
      socialMediaItem: socialMediaItem??this.socialMediaItem,
      random: random ?? this.random,
      mediaType: mediaType ?? this.mediaType
    );
  }

  @override
  List<Object?> get props => [action,message,socialMediaItem,random,mediaType];
}