import 'package:file_uploader_repository/src/models/social_media.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:file_chunked_uploader/file_chunked_uploader.dart" as fcu;

class UploadDocumentResponseWarning{
  final String? id;
  final List<SocialMedia> socialMediaItems;
  final List<String> messages;
  final bool isFileRequireResize;
  final bool isFileInvalid;
  final bool isFileNeedRotation;
  final bool isGlobal;
  UploadDocumentResponseWarning({
    this.id,
    this.socialMediaItems= const [],
    this.messages = const [],
    this.isFileInvalid = false,
    this.isFileRequireResize = false,
    this.isGlobal = false,
    this.isFileNeedRotation = false
  });


  List<String> getMessages(){
    return messages;
  }

  List<SocialMedia> getSocialMediaItem(){
    return socialMediaItems;
  }


  static List<UploadDocumentResponseWarning> fromApiForFileUploader(fcu.UploadDocumentWarning? data){
    List<UploadDocumentResponseWarning> items = [];
    try{
        if( data != null && data.messages.isNotEmpty && data.messages.isNotEmpty){
          final apps = [];
          for(fcu.UploadDocumentNetwork network in data.networks){
            final elm = apps.firstWhere((elm)=>elm == network.engine,orElse: () => null);
            if(elm == null){
              apps.add(network.engine);
            }
          }
          items.add(
            UploadDocumentResponseWarning(
                messages: data.messages ,
                socialMediaItems: apps.map((elm)=>SocialMedia.getItem(elm.toLowerCase())).toList(),
                isGlobal: true,
                isFileNeedRotation: data.isRotationRequired
            )
          );
        }
      for(fcu.UploadDocumentNetwork item in data?.networks ?? []){
        if(item.messages.isEmpty) continue;
        items.add(
          UploadDocumentResponseWarning(
            id:item.id,
            messages: item.messages,
            socialMediaItems: [SocialMedia.getItem(item.engine.toLowerCase()).setName(item.name)],
            isFileInvalid: item.isUndersized || item.isRatioUndersized,
            isFileRequireResize: item.isResizeRequired
          )
        );
      }
    }catch(err){
      if(kDebugMode) print(err);
    }
    return items;
  }

  static List<UploadDocumentResponseWarning> fromApiForSocialMediaList(fcu.UploadDocumentWarning? data){
    List<UploadDocumentResponseWarning> items = [];
    try{
      for(fcu.UploadDocumentNetwork item in data?.networks ?? []){
        items.add(
            UploadDocumentResponseWarning(
                id:item.id,
                messages: item.messages,
                socialMediaItems: [SocialMedia.getItem(item.engine.toLowerCase()).setName(item.name)],
                isFileInvalid: item.isUndersized || item.isRatioUndersized,
                isFileRequireResize: item.isResizeRequired
            )
        );
      }
    }catch(err){
      if(kDebugMode) print(err);
    }
    return items;
  }

  bool isWarningGlobal(){
    return isGlobal;
  }

  bool isNeedRotation(){
    return isFileNeedRotation;
  }

}