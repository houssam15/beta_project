import 'package:alpha_flutter_project/login/login.dart';
import 'package:alpha_flutter_project/social_media_list_form/src/models/models.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';

import '../bloc/local/social_media_list_form.local.bloc.dart';
import '../bloc/remote/social_media_list_form.remote.bloc.dart';

part 'social_media_list_form.event.dart';



class SocialMediaListFormEventBus{
  EventBus? _eventBus;
  SocialMediaListFormLocalBloc? _socialMediaListFormLocalBloc;
  SocialMediaListFormRemoteBloc? _socialMediaListFormRemoteBloc;

  SocialMediaListFormEventBus({
    EventBus? eventBus
  })
  :_eventBus = eventBus ?? EventBus();

  SocialMediaListFormEventBus setBlocs({required SocialMediaListFormLocalBloc socialMediaListFormLocalBloc,required SocialMediaListFormRemoteBloc socialMediaListFormRemoteBloc}){
    _socialMediaListFormRemoteBloc = socialMediaListFormRemoteBloc;
    _socialMediaListFormLocalBloc = socialMediaListFormLocalBloc;
    return this;
  }

  EventBus? getEventBus(){
    return _eventBus;
  }

  void listen(){
    //This event is for upload resized picture to server
    _eventBus?.on<SocialMediaListFormUploadResizedPictureEvent>().listen((event){
      _socialMediaListFormRemoteBloc?.add(SocialMediaListFormRemoteResizedFileUpload(event.socialMediaItem));
    });
  }



}