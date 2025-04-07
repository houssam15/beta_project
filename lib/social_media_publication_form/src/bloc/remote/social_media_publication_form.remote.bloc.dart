import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:equatable/equatable.dart";
import "../../models/models.dart";
import "package:file_uploader_repository/file_uploader_repository.dart" as fur;
import 'package:intl/intl.dart';

part 'social_media_publication_form.remote.event.dart';
part 'social_media_publication_form.remote.state.dart';

class SocialMediaPublicationFormRemoteBloc extends Bloc<SocialMediaPublicationFormRemoteEvent,SocialMediaPublicationFormRemoteState>{

  SocialMediaPublicationFormRemoteBloc({required this.uploadDocumentResponse,required this.fileUploaderRepository,this.mediaType,this.constrains,this.currentState})
      :super(currentState==null?SocialMediaPublicationFormRemoteState():currentState){
        on<SocialMediaPublicationFormRemoteTitleOrDescriptionChanged>(_onTitleOrDescriptionChanged);
        on<SocialMediaPublicationFormRemotePublishNowChanged>(_onPublishNowChanged);
        on<SocialMediaPublicationFormRemotePublishDateChanged>(_onPublishDateChanged);
        on<SocialMediaPublicationFormRemotePublishTimeChanged>(_onPublishTimeChanged);
        on<SocialMediaPublicationFormRemotePublishSubmitted>(_onFormSubmitted);
        on<SocialMediaPublicationFormRemotePublishLaterChanged>(_onPublishLaterChanged);
  }

  final UploadDocumentResponse uploadDocumentResponse;
  final fur.FileUploaderRepository fileUploaderRepository;
  dynamic mediaType;
  dynamic constrains;
  dynamic currentState;
  _onTitleOrDescriptionChanged(SocialMediaPublicationFormRemoteTitleOrDescriptionChanged event,Emitter<SocialMediaPublicationFormRemoteState> emit){
    try{
      emit(state.copyWith(title: event.title,description: event.description));
    }catch(err){
      print(err);
    }
  }

  _onPublishNowChanged(SocialMediaPublicationFormRemotePublishNowChanged event,Emitter<SocialMediaPublicationFormRemoteState> emit){
    try{
      emit(state.copyWith(publishNow: event.publishNow,decidePublishTimeLater:state.decidePublishTimeLater?false:null));
    }catch(err){
      print(err);
    }
  }

  _onPublishLaterChanged(SocialMediaPublicationFormRemotePublishLaterChanged event,Emitter<SocialMediaPublicationFormRemoteState> emit){
    try{
        emit(state.copyWith(decidePublishTimeLater: event.publishLater,publishNow:state.publishNow?false:null));
    }catch(err){
      print(err);
    }
  }

  _onPublishDateChanged(SocialMediaPublicationFormRemotePublishDateChanged event,Emitter<SocialMediaPublicationFormRemoteState> emit){
    try{
      if(event.publishDate.isToday() && state.publishTime.isInPast()){
        emit(state.copyWith(publishDate: event.publishDate,publishTime: TimeOfDay.now()));
      }else{
        emit(state.copyWith(publishDate: event.publishDate));
      }
    }catch(err){
      print(err);
    }
  }

  _onPublishTimeChanged(SocialMediaPublicationFormRemotePublishTimeChanged event,Emitter<SocialMediaPublicationFormRemoteState> emit){
    try{
      if (event.publishTime != null && state.publishDate.isToday()==true && event.publishTime!.isInPast()) {
        emit(state.copyWith(publishTime: event.publishTime,publishDate: DateTime.now()));
      } else {
        emit(state.copyWith(publishTime: event.publishTime));
      }
    }catch(err){
      print(err);
    }
  }

  _onFormSubmitted(SocialMediaPublicationFormRemotePublishSubmitted event,Emitter<SocialMediaPublicationFormRemoteState> emit) async{
    try{
      fur.UpdatePublicationResponse response = await this.fileUploaderRepository.updateDocument(
          fur.UpdatePublicationRequest.create(
              publicationId: this.uploadDocumentResponse.getPublicationId(),
              title: state.title,
              description: state.description,
              datedAt: state.decidePublishTimeLater?null:state.getDatedAt()//convert publishDate & publishTime to yyyy-mm-dd hh:mm:ss
          )
      );
      if(response.hasErrors()) emit(state.copyWith(action: SocialMediaPublicationFormActions.failure,errorMessage: response.errors.first));
      else emit(state.copyWith(action: SocialMediaPublicationFormActions.success));
    }catch(err){
      emit(state.copyWith(action: SocialMediaPublicationFormActions.failure,errorMessage: "An unexpected error happen, try again later please."));
    }
    //Back to initial action
    emit(state.copyWith(action: SocialMediaPublicationFormActions.none));
  }


}