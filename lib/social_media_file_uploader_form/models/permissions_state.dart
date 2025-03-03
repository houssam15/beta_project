import "package:equatable/equatable.dart";
import "package:file_uploader_repository/file_uploader_repository.dart" as file_upload_repository;
enum ShowMessageOptions{
  snackBar,dialog
}

enum PermissionsStatus {
  success,failure
}

class PermissionsState extends Equatable{
  PermissionsStatus status;
  String message;
  String title;
  ShowMessageOptions showMessageOption;
  List<String> permissionsNotRequestedYet;
  PermissionsState({
    this.status = PermissionsStatus.failure,
    this.message = "",
    this.title = "Permissions",
    this.showMessageOption = ShowMessageOptions.snackBar,
    this.permissionsNotRequestedYet = const []
  });

  @override
  List<Object?> get props => [message,title,showMessageOption];

  PermissionsState fromRepository(file_upload_repository.PermissionsState repository){
    return PermissionsState(
        status: repository.status==file_upload_repository.PermissionsStatus.granted?PermissionsStatus.success:PermissionsStatus.failure,
        message: repository.message,
        title: this.title,
        showMessageOption: repository.openSettingDialog?ShowMessageOptions.dialog:ShowMessageOptions.snackBar,
        permissionsNotRequestedYet:repository.permissionsNotRequestedYet
    );
  }

}