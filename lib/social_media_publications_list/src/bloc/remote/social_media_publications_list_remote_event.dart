part of "social_media_publications_list_remote_bloc.dart";

sealed class SocialMediaPublicationsListRemoteEvent extends Equatable{}

class SocialMediaPublicationsListRemoteListPublicationsRequested extends SocialMediaPublicationsListRemoteEvent{
  final BuildContext context;

  SocialMediaPublicationsListRemoteListPublicationsRequested({required this.context});

  @override
  List<Object?> get props => [context];
}

class SocialMediaPublicationsListRemotePublicationFetched extends SocialMediaPublicationsListRemoteEvent{
  final BuildContext context;
  final bool simulateLoading;
  SocialMediaPublicationsListRemotePublicationFetched({required this.context,this.simulateLoading = false});
  @override
  List<Object?> get props => [context,simulateLoading];
}