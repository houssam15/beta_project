import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "../../models/models.dart";
part 'social_media_list_form.remote.event.dart';
part 'social_media_list_form.remote.state.dart';

class SocialMediaListFormRemoteBloc  extends Bloc<SocialMediaListFormRemoteEvent,SocialMediaListFormRemoteState>{

  SocialMediaListFormRemoteBloc():super(SocialMediaListFormRemoteState()){
    on<SocialMediaListFormRemoteStarted>(_loadSocialMediaItems);
    on<SocialMediaListFormRemoteSocialMediaItemToggled>(_handleSocialMediaItemChanges);
    on<SocialMediaListFormSocialMediaItemsSelected>(_verifySelectedSocialMediaItems);
  }

  Future<void> _loadSocialMediaItems(SocialMediaListFormRemoteStarted event, Emitter<SocialMediaListFormRemoteState> emit) async {
    try{
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.loadingSocialMedia));
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.socialMediaLoaded,socialMediaItems: SocialMediaItem.fromRepository()));
    }catch(err){
      if(kDebugMode) print(err);
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.socialMediaFailed,message: "Can't load data"));
    }
  }

  Future<void> _handleSocialMediaItemChanges(SocialMediaListFormRemoteSocialMediaItemToggled event, Emitter<SocialMediaListFormRemoteState> emit) async {
    try{
      //Verify selected element

      emit(state.copyWith(enableNextAction: state.isSocialListItemsChecked()));
    }catch(err){
      if(kDebugMode) print(err);
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.socialMediaFailed,message: "Can't selected element"));
    }
  }

  Future<void> _verifySelectedSocialMediaItems(SocialMediaListFormSocialMediaItemsSelected event, Emitter<SocialMediaListFormRemoteState> emit) async {
    try{
      emit(state.copyWith(enableNextAction: state.isSocialListItemsChecked()));
    }catch(err){
      if(kDebugMode) print(err);
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.socialMediaFailed,message: "Can't selected element"));
    }
  }
}