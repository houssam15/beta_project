import 'dart:io';

import 'package:alpha_flutter_project/authentication/authentication.dart';
import 'package:alpha_flutter_project/file_uploader/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:file_uploader_repository/file_uploader_repository.dart' show FileUploaderRepository;
import '../models/models.dart';

part 'file_uploader.event.dart';
part 'file_uploader.state.dart';

class FileUploaderBloc extends Bloc<FileUploaderEvent,FileUploaderState>{
  FileUploaderBloc(this._fileUploaderRepository):super(FileUploaderState()){
    on<FileUploaderUploadRequested>(_onFileUploaded);
    on<FileUploaderUploadSourceRequested>(_onUploadSourceRequested);
    on<FileUploaderUploadTypeRequested>(_onUploadTypeRequested);
    on<FileUploaderSettingsOpened>(_openSettings);
    on<FileUploaderUploadToServer>(_uploadToServer);
  }

  final FileUploaderRepository _fileUploaderRepository;


  Future<void> _onFileUploaded(FileUploaderUploadRequested event, Emitter<FileUploaderState> emit) async{
    try{
        emit(state.copyWith(status: FileUploaderStatus.loading));
        await Future.delayed(Duration(milliseconds: 500));
        emit(state.copyWith(status: FileUploaderStatus.cameraOrGallery));
    }catch(err){
      emit(state.copyWith(status: FileUploaderStatus.failure));
    }
  }

  Future<void> _onUploadSourceRequested(FileUploaderUploadSourceRequested event, Emitter<FileUploaderState> emit)async{
    try{
      final result = await PermissionsState().fromRepository(
          await this._fileUploaderRepository.requestPermissions()
      );
      if(result.status==PermissionsStatus.failure){
          emit(state.copyWith(status: FileUploaderStatus.permissionsDenied,permissionsState: result));
      }else if(event.uploadSource==UploadSourceType.none){
        emit(state.copyWith(status: FileUploaderStatus.failure,errorMessage: "Upload source is empty, please choose one ..."));
      }else{
        state.set(sourceType: event.uploadSource);
        emit(state.copyWith(status: FileUploaderStatus.loading));
        await Future.delayed(Duration(milliseconds: 500));
        emit(state.copyWith(status: FileUploaderStatus.pictureOrVideo));
      }
    }catch(err){
      emit(state.copyWith(status: FileUploaderStatus.failure,errorMessage: "Internal error , when upload source requested"));
    }
  }


  Future<void> _onUploadTypeRequested(FileUploaderUploadTypeRequested event, Emitter<FileUploaderState> emit)async{
    try{
      if(event.mediaType==MediaType.none) {
        emit(state.copyWith(status: FileUploaderStatus.failure,errorMessage: "Choose file type please"));
      }else if(state.sourceType==UploadSourceType.none){
        emit(state.copyWith(status: FileUploaderStatus.failure,errorMessage: "Upload source is empty, please choose one ..."));
        await Future.delayed(Duration(seconds: 2));
        emit(state.copyWith(status: FileUploaderStatus.cameraOrGallery));
      }else{
        state.set(mediaType: event.mediaType);
        final result = await this._fileUploaderRepository.getFileFromSource(state.sourceType.toRepositoryUploadFileSource(),state.mediaType.toRepositoryMediaType());
        if(result.isError || result.isCanceled)  emit(state.copyWith(status: FileUploaderStatus.failure,errorMessage: result.message));
        else if(result.isSuccess) {
            emit(state.copyWith(status: FileUploaderStatus.readyToUpload,file:result.file));
        }else{
          throw new Exception("Unknown state");
        }
      }
    }catch(err){
      emit(state.copyWith(status: FileUploaderStatus.failure,errorMessage: "Internal error , when upload type requested"));
    }
  }

  Future<void> _openSettings(FileUploaderSettingsOpened event, Emitter<FileUploaderState> emit) async{
    try{
      await this._fileUploaderRepository.openSettingsToGrantPermissions();
    }catch(err){
      emit(state.copyWith(status: FileUploaderStatus.failure,errorMessage: "Internal error , when try to open settings"));
    }
  }

  Future<void> _uploadToServer(FileUploaderUploadToServer event, Emitter<FileUploaderState> emit) async{
    try {
      await for (int progress in _fileUploaderRepository.uploadFileToServer(state.file)) {
        emit(state.copyWith(status: FileUploaderStatus.progress, progress: progress));
        if (progress == 100) {
          emit(state.copyWith(status: FileUploaderStatus.success));
        }
      }
    } catch (error) {
      // Dispatch an error event or state when an error occurs
      if (kDebugMode) print("Upload failed with error: $error");
      emit(state.copyWith(status: FileUploaderStatus.progressFailure, errorMessage: error.toString()));
    }
  }

}