import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

enum Platforms {
  android,ios
}

class PlatformPermission {
  final Permission permission;
  final List<Platforms> supportedIn;

  PlatformPermission({
    required this.permission,
    List<Platforms>? supportedIn
  }):supportedIn = supportedIn ?? [Platforms.android,Platforms.ios];

  bool isSupported(){
    if(Platform.isAndroid){
      return supportedIn.contains(Platforms.android);
    }else if(Platform.isIOS){
      return supportedIn.contains(Platforms.ios);
    }else {
      return false;
    }
  }

}