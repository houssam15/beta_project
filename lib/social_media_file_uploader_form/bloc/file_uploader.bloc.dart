import 'dart:io';
import 'dart:math';
import 'package:alpha_flutter_project/authentication/authentication.dart';
import 'package:alpha_flutter_project/login/login.dart';
import 'package:localization_service/localization_service.dart';
import '../models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:file_uploader_repository/file_uploader_repository.dart' show FileUploaderRepository;
part 'file_uploader.event.dart';
part 'file_uploader.state.dart';

class FileUploaderBloc extends Bloc<FileUploaderEvent,FileUploaderState>{

  FileUploaderBloc(this._fileUploaderRepository):super(FileUploaderState()){
    on<FileUploaderStarted>(_onStarted);
    on<FileUploaderResetRequested>(_onResetRequested);
    on<FileUploaderUploadRequested>(_onFileUploaded);
    on<FileUploaderUploadSourceRequested>(_onUploadSourceRequested);
    on<FileUploaderUploadTypeRequested>(_onUploadTypeRequested);
    on<FileUploaderSettingsOpened>(_openSettings);
    on<FileUploaderUploadToServer>(_uploadToServer);
  }

  final FileUploaderRepository _fileUploaderRepository;

  Future<void> _onStarted(FileUploaderStarted event , Emitter<FileUploaderState> emit) async {
    try{
      emit(state.copyWith(pageStatus: FileUploaderPageStatus.started,status: FileUploaderStatus.loading));
      final constrains = await this._fileUploaderRepository.getConstrains();
      if(!constrains.isValid()){
        emit(state.copyWith(pageStatus: FileUploaderPageStatus.failure,action: FileUploaderAction.failure,errorMessage:LocalizationService.tr(constrains.getErrorMessage())));
      }else{
        emit(state.copyWith(pageStatus: FileUploaderPageStatus.started,status: FileUploaderStatus.pictureOrVideo,action: FileUploaderAction.none,constrains: Constrains().setConstrains(constrains)));
      }
    }catch(err){
      emit(state.copyWith(pageStatus: FileUploaderPageStatus.failure));
    }
  }

  Future<void> _onResetRequested(FileUploaderResetRequested event, Emitter<FileUploaderState> emit) async{
    emit(state.reset());
  }

  Future<void> _onFileUploaded(FileUploaderUploadRequested event, Emitter<FileUploaderState> emit) async{
    try{
        emit(state.copyWith(status: FileUploaderStatus.loading));
        final result = await PermissionsState().fromRepository(
            await this._fileUploaderRepository.requestPermissions()
        );
        if(result.status==PermissionsStatus.failure){
          emit(state.copyWith(action: FileUploaderAction.permissionsDenied,pageStatus: FileUploaderPageStatus.failure,permissionsState: result));
        }else{
          emit(state.copyWith(status: FileUploaderStatus.pictureOrVideo));
        }
    }catch(err){
      emit(state.copyWith(action: FileUploaderAction.failure,pageStatus: FileUploaderPageStatus.failure));
    }
  }

  Future<void> _onUploadSourceRequested(FileUploaderUploadSourceRequested event, Emitter<FileUploaderState> emit)async{
    try{
      if(event.uploadSource==UploadSourceType.none){
        emit(state.copyWith(action: FileUploaderAction.failure,errorMessage: "Upload source is empty, please choose one ..."));
      }else{
        emit(state.copyWith(status: FileUploaderStatus.loading,sourceType: event.uploadSource));
        final result = await this._fileUploaderRepository.getFileFromSource(event.uploadSource.toRepositoryUploadFileSource(),state.mediaType.toRepositoryMediaType(),
            supportedExtensions: state.mediaType == MediaType.picture
            ? state.constrains.getGlobalPictureFormats()
            : state.constrains.getGlobalVideoFormats(),
            minSize:state.mediaType == MediaType.picture
                ? state.constrains.getGlobalPictureMinSize()
                : state.constrains.getGlobalVideoMinSize(),
            maxSize:state.mediaType == MediaType.picture
                ? state.constrains.getGlobalPictureMaxSize()
                : state.constrains.getGlobalVideoMaxSize()

        );
        if(result.isError || result.isCanceled)  emit(state.copyWith(pageStatus: FileUploaderPageStatus.initial,action: FileUploaderAction.failure,errorMessage: LocalizationService.tr(result.message)));
        else if(result.isSuccess) {
          emit(state.copyWith(status: FileUploaderStatus.readyToUpload,file:result.file));
        }else{
          throw new Exception("Unknown state");
        }
      }
    }catch(err){
      emit(state.copyWith(pageStatus: FileUploaderPageStatus.failure,action: FileUploaderAction.failure,errorMessage: LocalizationService.tr("Internal error , when upload source requested")));
    }
  }


  Future<void> _onUploadTypeRequested(FileUploaderUploadTypeRequested event, Emitter<FileUploaderState> emit) async{
    try{
      if(event.mediaType==MediaType.none) {
        emit(state.copyWith(action: FileUploaderAction.failure,errorMessage: LocalizationService.tr("Choose file type please"))..randomize());
      }else{
        emit(state.copyWith(status: FileUploaderStatus.loading));
        await Future.delayed(Duration(milliseconds: 500));
        emit(state.copyWith(status: FileUploaderStatus.cameraOrGallery,mediaType: event.mediaType));
      }
    }catch(err){
      emit(state.copyWith(action: FileUploaderAction.failure,errorMessage: LocalizationService.tr("Internal error , when upload type requested"))..randomize());
    }
  }

  Future<void> _openSettings(FileUploaderSettingsOpened event, Emitter<FileUploaderState> emit) async{
    try{
      await this._fileUploaderRepository.openSettingsToGrantPermissions();
    }catch(err){
      emit(state.copyWith(action: FileUploaderAction.failure,errorMessage: "Internal error , when try to open settings"));
    }
  }

  Future<void> _uploadToServer(FileUploaderUploadToServer event, Emitter<FileUploaderState> emit) async{
    try {
      await for (int progress in _fileUploaderRepository.uploadFileToServer(state.file)) {
        emit(state.copyWith(action: FileUploaderAction.progress,isUploading: true, progress: progress));
      }
      if(_fileUploaderRepository.getUploadDocumentResponse()==null){
        throw new Exception("Invalid response");
      }else if(!_fileUploaderRepository.getUploadDocumentResponse()!.isValid()){
        emit(state.copyWith(
            action: FileUploaderAction.progressFailure,
            isUploading: false,
            errorMessage: _fileUploaderRepository.getUploadDocumentResponse()!.getErrors()!.first
        ));
      }else{
        emit(state.copyWith(action: FileUploaderAction.success,isUploading: false,uploadDocumentResponse: UploadDocumentResponse.create(_fileUploaderRepository.getUploadDocumentResponse())));
      }
    } catch (error) {
      emit(state.copyWith(action: FileUploaderAction.progressFailure,isUploading: false, errorMessage: LocalizationService.tr("Server unavailable for the moment,try again later")).randomize());
    }
  }

}