import "package:flutter_bloc/flutter_bloc.dart";
import "package:equatable/equatable.dart";

part "social_media_publications_list_remote_event.dart";
part "social_media_publications_list_remote_state.dart";

class SocialMediaPublicationsListRemoteBloc extends Bloc<SocialMediaPublicationsListRemoteEvent,SocialMediaPublicationsListRemoteState>{
  SocialMediaPublicationsListRemoteBloc():super(SocialMediaPublicationsListRemoteState());
}