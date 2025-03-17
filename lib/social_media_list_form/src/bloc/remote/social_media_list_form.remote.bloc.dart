import "dart:io";

import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "../../event_bus/social_media_list_form.event_bus.dart";
import "../../models/models.dart";
import "package:social_media_list_form_repository/social_media_list_form_repository.dart" as social_media_list_form_repository;

part 'social_media_list_form.remote.event.dart';
part 'social_media_list_form.remote.state.dart';

class SocialMediaListFormRemoteBloc  extends Bloc<SocialMediaListFormRemoteEvent,SocialMediaListFormRemoteState>{


  SocialMediaListFormRemoteBloc(this.fileId,{
    social_media_list_form_repository.SocialMediaListFormRepository? socialMediaListFormRepository,
    SocialMediaListFormEventBus? socialMediaListFormEventBus
  })
  :socialMediaListFormRepository = socialMediaListFormRepository??social_media_list_form_repository.SocialMediaListFormRepository(),
   socialMediaListFormEventBus = socialMediaListFormEventBus ?? SocialMediaListFormEventBus(),
  super(SocialMediaListFormRemoteState(fileId: fileId)){
    on<SocialMediaListFormRemoteStarted>(_loadSocialMediaItems);
    on<SocialMediaListFormRemoteSocialMediaItemToggled>(_handleSocialMediaItemChanges);
    on<SocialMediaListFormSocialMediaItemsSelected>(_verifySelectedSocialMediaItems);
    on<SocialMediaListFormSocialMediaItemEdited>(_updateEditedElementState);
    on<SocialMediaListFormRemoteResizedFileUpload>(_uploadResizedPicture);
  }

  final String fileId;
  final social_media_list_form_repository.SocialMediaListFormRepository socialMediaListFormRepository;
  final SocialMediaListFormEventBus socialMediaListFormEventBus;

  Future<void> _loadSocialMediaItems(SocialMediaListFormRemoteStarted event, Emitter<SocialMediaListFormRemoteState> emit) async {
    try{
      ///TODO : get social media items by fileId
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.loadingSocialMedia));
      await Future.delayed(Duration(seconds: 1));
      final socialMediaList = await socialMediaListFormRepository.getSocialMediaList();
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.socialMediaLoaded,socialMediaItems: SocialMediaItem.fromRepository(socialMediaList)));
    }catch(err){
      if(kDebugMode) print(err);
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.socialMediaFailed,message: "Can't load data"));
    }
  }

  Future<void> _handleSocialMediaItemChanges(SocialMediaListFormRemoteSocialMediaItemToggled event, Emitter<SocialMediaListFormRemoteState> emit) async {
    try{
      event.socialMediaItem.isSelected = event.value??false;
      emit(state.copyWith(action: SocialMediaListFormRemoteActions.switchItemStatus,itemToEdit: event.socialMediaItem));
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
  Future<void> _uploadResizedPicture(SocialMediaListFormRemoteResizedFileUpload event,Emitter<SocialMediaListFormRemoteState> emit) async {
    try{

      emit(state.copyWith(itemToEdit:event.socialMediaItem.setLoading(true)));
      if(event.socialMediaItem.error?.editedFile is! File) return;
      social_media_list_form_repository.UploadedFile uploadedFile = await socialMediaListFormRepository.uploadPictureForPublication(
          event.socialMediaItem.error!.editedFile!,
          params: {"socialMediaItemId":event.socialMediaItem.id}
      );
      emit(state.copyWith(itemToEdit:event.socialMediaItem.setLoading(false)));
      if(uploadedFile.hasError()) {
        emit(state.copyWith(action: SocialMediaListFormRemoteActions.resizedPictureUploadedFailed));
      }else{
        emit(state.copyWith(action: SocialMediaListFormRemoteActions.resizedPictureUploaded,itemToEdit: event.socialMediaItem.setUploadUrl(uploadedFile.getPictureUrl())));
      }
    }catch(err){
      if(kDebugMode) print(err);
      emit(state.copyWith(status: SocialMediaListFormRemoteStatus.socialMediaFailed,message: "Can't upload resized picture"));
    }
  }

}