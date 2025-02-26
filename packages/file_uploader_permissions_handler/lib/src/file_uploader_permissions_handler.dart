import 'package:file_uploader_permissions_handler/src/models/models.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUploaderPermissionsHandler{
  final List<Permission> _permissions = [
    Permission.manageExternalStorage,
    Permission.photos,
    Permission.camera,
  ];

  List<Permission> get  permissions => _permissions;

  /// Check for all permissions required by file uploader.
  /// If any permission is not granted, it will request it.
  /// Returns true only if all permissions are granted.
  Future<PermissionsState> requestPermissions() async{
    PermissionsState permissionsState = PermissionsState();
    List<String> deniedPermissionNames = [];
    try{
      // Check the status of each permission.
      Map<Permission, PermissionStatus> statuses = await Future.wait(
        permissions.map((permission) => permission.status),
      ).then((statusesList) {
        return Map.fromIterables(permissions, statusesList);
      });

      // Filter out the permissions that are not granted.
      List<Permission> notGranted = statuses.entries
          .where((entry) => !entry.value.isGranted)
          .map((entry) => entry.key)
          .toList();

      // If there are permissions that are not granted, request them.
      if (notGranted.isNotEmpty) {
        Map<Permission, PermissionStatus> requested = await notGranted.request();

        // Build list of denied permissions (those that are denied but not granted)
        requested.forEach((permission, status) {
          if (status == PermissionStatus.permanentlyDenied) {
            deniedPermissionNames.add(permission.toString());
          }
        });

        // Check if all requested permissions are now granted.
        bool allGranted = requested.values.every((status) => status.isGranted);
        // Determine if any permission requires opening settings.
        // We consider a permission to need opening settings if it is permanently denied.
        bool needOpenSettings = requested.values.any((status) => status.isPermanentlyDenied);

        permissionsState.set(
            isAllPermissionsGranted: allGranted,
            isPermissionsNeedOpenSettings: needOpenSettings,
            permissionsNotRequestedYet: deniedPermissionNames,
        );
      } else {
        // All permissions are already granted.
        permissionsState.set(isAllPermissionsGranted: true);
      }
    }catch(err){
      if (kDebugMode) print("Permission request error: $err");
      permissionsState.set(isAllPermissionsGranted: true);
    }

    return permissionsState;
  }


  Future<bool> openSettingsToGrantpermissions() async {
    try{
      bool canOpenSetting = await openAppSettings();
      if(!canOpenSetting) return false;
      return true;
    }catch(err){
      if (kDebugMode) print("Permission request error: $err");
      return false;
    }
  }

}