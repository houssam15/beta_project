import 'package:equatable/equatable.dart';

class PermissionsState extends Equatable{
  bool isAllPermissionsGranted;
  bool isPermissionsNeedOpenSettings;
  List<String> permissionsNotRequestedYet;
  PermissionsState({
    this.isAllPermissionsGranted = false,
    this.isPermissionsNeedOpenSettings = false,
    this.permissionsNotRequestedYet = const []
  });

   PermissionsState set({
     bool?  isAllPermissionsGranted,
     bool? isPermissionsNeedOpenSettings,
     List<String>? permissionsNotRequestedYet
   }){
     this.isAllPermissionsGranted = isAllPermissionsGranted??this.isAllPermissionsGranted;
     this.isPermissionsNeedOpenSettings = isPermissionsNeedOpenSettings??this.isPermissionsNeedOpenSettings;
     this.permissionsNotRequestedYet = permissionsNotRequestedYet??this.permissionsNotRequestedYet;
      return this;
   }

  @override
  List<Object?> get props => [isAllPermissionsGranted,isPermissionsNeedOpenSettings,permissionsNotRequestedYet];

}