import 'package:equatable/equatable.dart';

enum PermissionsStatus{
    granted,denied
}

class PermissionsState extends Equatable {
  final PermissionsStatus status;
  final String message;
  final bool openSettingDialog;
  final List<String> permissionsNotRequestedYet;

  PermissionsState({
    required this.status,
    this.message = "",
    this.openSettingDialog = false,
    this.permissionsNotRequestedYet = const []
  });

  @override
  List<Object> get props => [status,message,openSettingDialog,permissionsNotRequestedYet];
}