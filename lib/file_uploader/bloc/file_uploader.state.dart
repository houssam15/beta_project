
part of 'file_uploader.bloc.dart';

enum FileUploaderStatus{initial,success,permissionsDenied,failure,progress,progressFailure,loading,picking,cameraOrGallery,pictureOrVideo,readyToUpload}

final class FileUploaderState extends Equatable{

  FileUploaderState({
    this.status = FileUploaderStatus.initial,
    PermissionsState? permissionsState,
    this.errorMessage = "unknown error",
    this.mediaType = MediaType.none,
    this.sourceType = UploadSourceType.none,
    this.progress=0,
    File? file 
  }): permissionsState = permissionsState ??  PermissionsState(),
    file = file??File("no_path");


  FileUploaderStatus status;
  PermissionsState permissionsState;
  MediaType mediaType;
  UploadSourceType sourceType;
  String errorMessage;
  File file;
  int progress;


  FileUploaderState copyWith({
    FileUploaderStatus? status,
    PermissionsState? permissionsState,
    String? errorMessage,
    UploadSourceType? sourceType,
    MediaType? mediaType,
    File? file,
    int? progress
  }) {
    return FileUploaderState(
      status: status ?? this.status,
        permissionsState: permissionsState??this.permissionsState,
        errorMessage: errorMessage??this.errorMessage,
        sourceType:sourceType??this.sourceType,
        mediaType: mediaType??this.mediaType,
        file: file??this.file,
        progress: progress??this.progress
    );
  }

  FileUploaderState reset(){
    return FileUploaderState();
  }

  FileUploaderState set({
    FileUploaderStatus? status,
    PermissionsState? permissionsState,
    String? errorMessage,
    UploadSourceType? sourceType,
    MediaType? mediaType,
    File? file,
    int? progress
  }) {
        this.status= status ?? this.status;
        this.permissionsState= permissionsState??this.permissionsState;
        this.errorMessage= errorMessage??this.errorMessage;
        this.sourceType=sourceType??this.sourceType;
        this.mediaType= mediaType??this.mediaType;
        this.file = file?? this.file;
        this.progress=progress??this.progress;
     return this;
  }




  @override
  List<Object> get props => [status,permissionsState,errorMessage,sourceType,mediaType,file,progress];
}