import "package:flutter_bloc/flutter_bloc.dart";
import "package:equatable/equatable.dart";
import "package:social_media_publications_repository/social_media_publications_repository.dart";

part "social_media_publications_list_remote_event.dart";
part "social_media_publications_list_remote_state.dart";

class SocialMediaPublicationsListRemoteBloc extends Bloc<SocialMediaPublicationsListRemoteEvent,SocialMediaPublicationsListRemoteState>{
  final SocialMediaPublicationsRepository _socialMediaPublicationsRepository;
  SocialMediaPublicationsListRemoteBloc()
  :_socialMediaPublicationsRepository = SocialMediaPublicationsRepository()
  ,super(SocialMediaPublicationsListRemoteState()){
   on<SocialMediaPublicationsListRemoteListPublicationsRequested>(_onListPublicationsRequested);
  }

  _onListPublicationsRequested(SocialMediaPublicationsListRemoteListPublicationsRequested event,Emitter<SocialMediaPublicationsListRemoteState> emit) async {
    try{
      GetPublicationsResponse response = await _socialMediaPublicationsRepository.getPublications(GetPublicationsRequest());
      if(!response.isValid()){
        print(response.getErrorMessage());
      }else{
        print(response.getPublications());
      }
    }catch(err){
      emit(state.copyWith(status: SocialMediaPublicationsListRemoteStatus.failed,errorMessage: "Unexpected error"));
    }
  }


}