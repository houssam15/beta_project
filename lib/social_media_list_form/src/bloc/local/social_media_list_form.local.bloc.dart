import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/login/login.dart";
import "package:alpha_flutter_project/social_media_list_form/src/models/models.dart";
import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "package:localization_service/localization_service.dart";
import "package:social_media_list_form_repository/social_media_list_form_repository.dart" as social_media_list_form_repository;
import 'dart:math';
import "../../event_bus/social_media_list_form.event_bus.dart";
import "../remote/social_media_list_form.remote.bloc.dart";
part 'social_media_list_form.local.event.dart';
part 'social_media_list_form.local.state.dart';

class SocialMediaListFormLocalBloc  extends Bloc<SocialMediaListFormLocalEvent,SocialMediaListFormLocalState>{


  SocialMediaListFormLocalBloc(this.uploadDocumentResponse,{
    social_media_list_form_repository.SocialMediaListFormRepository? socialMediaListFormRepository,
    SocialMediaListFormEventBus? socialMediaListFormEventBus,
    required this.mediaType,
    required this.constrains

  })
  :socialMediaListFormRepository = socialMediaListFormRepository??social_media_list_form_repository.SocialMediaListFormRepository(),
   socialMediaListFormEventBus = socialMediaListFormEventBus ?? SocialMediaListFormEventBus(),
   super(SocialMediaListFormLocalState(mediaType: mediaType,constrains:constrains)){
    on<SocialMediaListFormLocalResizePictureRequested>(_resizePicture);
  }

  final social_media_list_form_repository.SocialMediaListFormRepository socialMediaListFormRepository;
  final UploadDocumentResponse uploadDocumentResponse;
  final SocialMediaListFormEventBus socialMediaListFormEventBus;
  final MediaType mediaType;
  final Constrains? constrains;

  Future<void> _resizePicture(SocialMediaListFormLocalResizePictureRequested event, Emitter<SocialMediaListFormLocalState> emit) async {
    try{
      social_media_list_form_repository.ResizedFile result = await socialMediaListFormRepository
          .setValidConstraints(event.socialMediaItem.error?.validConstraints.map(((elm) => elm.toRepository())).toList())
          .setFileParams(social_media_list_form_repository.FileParams(
            fileRequestOptions: social_media_list_form_repository.RequestOptions(
                method: "get",
                baseUrl: event.socialMediaItem.getUploadUrl(),
                token: Config.token
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
      emit(state.copyWith(action: SocialMediaListFormLocalAction.resizeFailed,message: LocalizationService.tr("failed to resize picture"),random: Random().nextInt(100000).toString()));
    }
  }

}