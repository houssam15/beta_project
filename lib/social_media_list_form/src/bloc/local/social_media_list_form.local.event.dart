part of "social_media_list_form.remote.bloc.dart";

sealed class SocialMediaListFormRemoteEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

// Event to signify the start of loading data
final class SocialMediaListFormRemoteStarted extends SocialMediaListFormRemoteEvent {}

//Event when user select a social media item
final class SocialMediaListFormRemoteSocialMediaItemToggled extends SocialMediaListFormRemoteEvent {
  final SocialMediaItem socialMediaItem;
  final bool? value;
  SocialMediaListFormRemoteSocialMediaItemToggled(this.socialMediaItem,this.value);

  @override
  List<Object?> get props =>[ ...super.props,socialMediaItem,value];
}

//Event when user select items
final class SocialMediaListFormSocialMediaItemsSelected extends SocialMediaListFormRemoteEvent {}

final class SocialMediaListFormSocialMediaItemEdited extends SocialMediaListFormRemoteEvent{
  final SocialMediaItem socialMediaItem;
  SocialMediaListFormSocialMediaItemEdited(this.socialMediaItem);
}


