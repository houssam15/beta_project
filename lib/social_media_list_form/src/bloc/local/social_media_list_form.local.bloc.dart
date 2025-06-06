import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/login/login.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/social_media_file_uploader_form.dart";
import "package:alpha_flutter_project/social_media_list_form/src/models/models.dart";
import "package:equatable/equatable.dart";
import "package:flutter/foundation.dart";
import "package:localization_service/localization_service.dart";
import "package:social_media_list_form_repository/social_media_list_form_repository.dart" as social_media_list_form_repository;
import 'dart:math';
import "../../event_bus/social_media_list_form.event_bus.dart";
import "../remote/social_media_list_form.remote.bloc.dart";
import "package:file_uploader_repository/file_uploader_repository.dart" as fur;

part 'social_media_list_form.local.event.dart';
part 'social_media_list_form.local.state.dart';

class SocialMediaListFormLocalBloc  extends Bloc<SocialMediaListFormLocalEvent,SocialMediaListFormLocalState>{

  SocialMediaListFormLocalBloc(this.uploadDocumentResponse,{
    required this.socialMediaListFormRepository,
    SocialMediaListFormEventBus? socialMediaListFormEventBus,
    required this.mediaType,
    required this.constrains,
    required this.fileUploaderRepository,
    required this.previousState

  })
   :socialMediaListFormEventBus = socialMediaListFormEventBus ?? SocialMediaListFormEventBus(),
   super(SocialMediaListFormLocalState(mediaType: mediaType,constrains:constrains)){
    on<SocialMediaListFormLocalResizePictureRequested>(_resizePicture);
    on<SocialMediaListFormLocalUploadPictureRequested>(_changeFile);
  }

  final social_media_list_form_repository.SocialMediaListFormRepository socialMediaListFormRepository;
  final UploadDocumentResponse uploadDocumentResponse;
  final SocialMediaListFormEventBus socialMediaListFormEventBus;
  final MediaType mediaType;
  final Constrains? constrains;
  final fur.FileUploaderRepository fileUploaderRepository;
  final dynamic previousState;

  Future<void> _resizePicture(SocialMediaListFormLocalResizePictureRequested event, Emitter<SocialMediaListFormLocalState> emit) async {
    try{
      event.socialMediaItem.setLoading(true);
      emit(state.copyWith(random:Random().nextInt(100000).toString() ));
      dynamic result = await socialMediaListFormRepository
          .setValidConstraints(event.socialMediaItem.error?.validConstraints.map(((elm) => elm.toRepository())).toList())
          .setFileParams(social_media_list_form_repository.FileParams(
            fileRequestOptions: social_media_list_form_repository.RequestOptions(
                method: "get",
                baseUrl: event.socialMediaItem.getUploadUrl(),
                token: Config.authorizationToken
            )
          ))
          .setContext(event.context)
          .loadFile();
      event.socialMediaItem.setLoading(false);
      emit(state.copyWith(random:Random().nextInt(100000).toString() ));
      social_media_list_form_repository.ResizedFile resizedFile = await socialMediaListFormRepository.resizeFile(result);
      //Set edited file
      event.socialMediaItem.error?.setEditedFile(resizedFile.file).setExifData(resizedFile.exifData);
      //emit(state.copyWith(action: SocialMediaListFormLocalAction.resizeSuccess,socialMediaItem: event.socialMediaItem,message: "File resized successfully"));
      this.socialMediaListFormEventBus.getEventBus()?.fire(SocialMediaListFormUploadResizedPictureEvent(event.socialMediaItem));
    }catch(err){
      if(kDebugMode) print(err);
      //emit(state.copyWith(action: SocialMediaListFormLocalAction.resizeFailed,message: LocalizationService.tr("failed to resize picture"),random: Random().nextInt(100000).toString()));
    }
  }

  Future<void> _changeFile(SocialMediaListFormLocalUploadPictureRequested event, Emitter<SocialMediaListFormLocalState> emit) async {
    try{
      if(event.context==null) return;
      dynamic result = await showModalBottomSheet(
        context: event.context!,
        isScrollControlled: true, // Allows full-screen height if needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext bottomSheetContext) {
          return //SizedBox(
            //height: MediaQuery.of(event.context!).size.height * 0.9, // Adjust height
            SizedBox(
              height: MediaQuery.of(event.context!).size.height * 0.9,
              child: Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (_) =>
                        SocialMediaFileUploaderForm(
                          arguments: SocialMediaFileUploaderFormArguments(
                              mediaType: MediaType.none.toString(),
                              modifySingleDocumentForPublication: true,
                              previousState: previousState,
                              hideSidebar: true,
                              hideAppbar: true,
                              uploadPath: Config.mediaLargeFileUploadForPublicationEndpoint,
                              publicationId:uploadDocumentResponse.getPublicationId(),
                              accountId: event.socialMediaItem.id
                          ),
                        ),
                  );
                },
              ),
            );
        },
      );

      //Success
      if(result!=null){
        this.socialMediaListFormEventBus.getEventBus()?.fire(SocialMediaListFormFileChangedSuccessfullyEvent(event.socialMediaItem,result));
        emit(state.copyWith(action: SocialMediaListFormLocalAction.changeSuccess,message: LocalizationService.tr("File changed successfully"),random: Random().nextInt(100000).toString()));
      }else{
        emit(state.copyWith(action: SocialMediaListFormLocalAction.changeFailed,message: LocalizationService.tr("File is invalid , try an other one !"),random: Random().nextInt(100000).toString()));
      }
    }catch(err){
      if(kDebugMode) print(err);
      emit(state.copyWith(action: SocialMediaListFormLocalAction.changeFailed,message: LocalizationService.tr("failed to change picture"),random: Random().nextInt(100000).toString()));
    }
  }

}