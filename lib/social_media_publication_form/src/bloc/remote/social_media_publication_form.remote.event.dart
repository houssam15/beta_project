part of 'social_media_publication_form.remote.bloc.dart';

sealed class SocialMediaPublicationFormRemoteEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class SocialMediaPublicationFormRemoteTitleOrDescriptionChanged extends SocialMediaPublicationFormRemoteEvent{
  final String title;
  final String description;
  SocialMediaPublicationFormRemoteTitleOrDescriptionChanged(this.title,this.description);
}

class SocialMediaPublicationFormRemotePublishNowChanged extends SocialMediaPublicationFormRemoteEvent{
  final bool publishNow;
  SocialMediaPublicationFormRemotePublishNowChanged(this.publishNow);
}

class SocialMediaPublicationFormRemotePublishLaterChanged extends SocialMediaPublicationFormRemoteEvent{
  final bool publishLater;
  SocialMediaPublicationFormRemotePublishLaterChanged(this.publishLater);
}

class SocialMediaPublicationFormRemotePublishDateChanged extends SocialMediaPublicationFormRemoteEvent{
  final DateTime publishDate;
  SocialMediaPublicationFormRemotePublishDateChanged(this.publishDate);
}


class SocialMediaPublicationFormRemotePublishTimeChanged extends SocialMediaPublicationFormRemoteEvent{
  final TimeOfDay? publishTime;
  SocialMediaPublicationFormRemotePublishTimeChanged(this.publishTime);
}


class SocialMediaPublicationFormRemotePublishSubmitted extends SocialMediaPublicationFormRemoteEvent{}
