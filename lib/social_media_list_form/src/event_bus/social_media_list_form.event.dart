part of 'social_media_list_form.event_bus.dart';
class SocialMediaListFormUploadResizedPictureEvent{
  final SocialMediaItem socialMediaItem;
  SocialMediaListFormUploadResizedPictureEvent(this.socialMediaItem);
}

class SocialMediaListFormFileChangedSuccessfullyEvent{
  final SocialMediaItem socialMediaItem;
  final dynamic result;
  SocialMediaListFormFileChangedSuccessfullyEvent(this.socialMediaItem,this.result);

}