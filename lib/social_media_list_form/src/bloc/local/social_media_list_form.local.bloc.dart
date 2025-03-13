import "dart:io";

import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "../../models/models.dart";
part 'social_media_list_form.remote.event.dart';
part 'social_media_list_form.remote.state.dart';

class SocialMediaListFormRemoteBloc  extends Bloc<SocialMediaListFormRemoteEvent,SocialMediaListFormRemoteState>{

  final String fileId;

  SocialMediaListFormRemoteBloc(this.fileId):super(SocialMediaListFormRemoteState(fileId: fileId)){
    on<SocialMediaListFormRemoteStarted>(_loadSocialMediaItems);
    on<SocialMediaListFormRemoteSocialMediaItemToggled>(_handleSocialMediaItemChanges);
    on<SocialMediaListFormSocialMediaItemsSelected>(_verifySelectedSocialMediaItems);
    on<SocialMediaListFormSocialMediaItemEdited>(_updateEditedElementState);
  }

  Future<void> _loadSocialMediaItems(SocialMediaListFormRemoteStarted event, Emitter<SocialMediaListFormRemoteState> emit) async {
    try{
      ///TODO : get social media items by fileId
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
      //Check if elm has error and need edit
      if(event.value==true && event.socialMediaItem.hasError()==true){
          emit(state.copyWith(action: SocialMediaListFormRemoteActions.itemNeedEdit,itemToEdit: event.socialMediaItem));
      }else{
        event.socialMediaItem.isSelected = event.value??false;
        emit(state.copyWith(action: SocialMediaListFormRemoteActions.switchItemStatus,itemToEdit: event.socialMediaItem));
      }
      emit(state.copyWith(action: SocialMediaListFormRemoteActions.updateNextAction,enableNextAction: state.isSocialListItemsChecked()));
    }catch(err){
      if(kDebugMode) print(err);
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.socialMediaFailed,message: "Can't selected element"));
    }
  }

  Future<void> _verifySelectedSocialMediaItems(SocialMediaListFormSocialMediaItemsSelected event, Emitter<SocialMediaListFormRemoteState> emit) async {
    try{
      emit(state.copyWith(action: SocialMediaListFormRemoteActions.updateNextAction,enableNextAction: state.isSocialListItemsChecked()));
    }catch(err){
      if(kDebugMode) print(err);
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.socialMediaFailed,message: "Can't selected element"));
    }
  }

  Future<void> _updateEditedElementState(SocialMediaListFormSocialMediaItemEdited event, Emitter<SocialMediaListFormRemoteState> emit) async {
    try{
      //If valid pass set elm as selected and vide itemNeedEdit
      event.socialMediaItem.changeIsSelected(true);
      emit(state.copyWith(action: SocialMediaListFormRemoteActions.updateItemStatus));
    }catch(err){
      if(kDebugMode) print(err);
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.socialMediaFailed,message: "Can't update edited element"));
    }
  }

}