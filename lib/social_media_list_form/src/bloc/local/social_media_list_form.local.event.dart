part of "social_media_list_form.local.bloc.dart";

sealed class SocialMediaListFormLocalEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SocialMediaListFormLocalResizePictureRequested extends SocialMediaListFormLocalEvent{
  final SocialMediaItem socialMediaItem;
  final BuildContext context;
  SocialMediaListFormLocalResizePictureRequested(this.socialMediaItem,this.context);
}

class SocialMediaListFormLocalUploadPictureRequested extends SocialMediaListFormLocalEvent{
  final SocialMediaItem socialMediaItem;
  final BuildContext? context;
  SocialMediaListFormLocalUploadPictureRequested(this.socialMediaItem,this.context);
}

