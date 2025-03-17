
import "dart:io";

import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/login/login.dart";
import "package:alpha_flutter_project/social_media_list_form/src/models/models.dart";
import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "package:social_media_list_form_repository/social_media_list_form_repository.dart" as social_media_list_form_repository;
import 'dart:math';
import "../../event_bus/social_media_list_form.event_bus.dart";
part 'social_media_list_form.local.event.dart';
part 'social_media_list_form.local.state.dart';

class SocialMediaListFormLocalBloc  extends Bloc<SocialMediaListFormLocalEvent,SocialMediaListFormLocalState>{


  SocialMediaListFormLocalBloc(this.fileId,{
    social_media_list_form_repository.SocialMediaListFormRepository? socialMediaListFormRepository,
    SocialMediaListFormEventBus? socialMediaListFormEventBus
  })
  :socialMediaListFormRepository = socialMediaListFormRepository??social_media_list_form_repository.SocialMediaListFormRepository(),
   socialMediaListFormEventBus = socialMediaListFormEventBus ?? SocialMediaListFormEventBus(),
   super(SocialMediaListFormLocalState()){
    on<SocialMediaListFormLocalResizePictureRequested>(_resizePicture);
  }

  final social_media_list_form_repository.SocialMediaListFormRepository socialMediaListFormRepository;
  final String fileId;
  final SocialMediaListFormEventBus socialMediaListFormEventBus;

  Future<void> _resizePicture(SocialMediaListFormLocalResizePictureRequested event, Emitter<SocialMediaListFormLocalState> emit) async {
    try{
      social_media_list_form_repository.ResizedFile result = await socialMediaListFormRepository
          .setValidConstraints(event.socialMediaItem.error?.validConstraints?.toRepository())
          .setFileParams(social_media_list_form_repository.FileParams(
            fileRequestOptions: social_media_list_form_repository.RequestOptions(
                method: "get",
                baseUrl: "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8aW1hZ2V8ZW58MHx8MHx8fDA%3D"
            )
          ))
          .setContext(event.context)
          .loadFileAndResize();
      //Set edited file
      event.socialMediaItem.error?.setEditedFile(result.file);
      //emit(state.copyWith(action: SocialMediaListFormLocalAction.resizeSuccess,socialMediaItem: event.socialMediaItem,message: "File resized successfully"));
      this.socialMediaListFormEventBus.getEventBus()?.fire(SocialMediaListFormUploadResizedPictureEvent(event.socialMediaItem));
    }catch(err){
      if(kDebugMode) print(err);
      emit(state.copyWith(action: SocialMediaListFormLocalAction.resizeFailed,message: "failed to resize picture",random: Random().nextInt(100000).toString()));
    }
  }


}