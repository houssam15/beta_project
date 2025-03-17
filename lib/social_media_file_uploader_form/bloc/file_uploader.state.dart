
part of 'file_uploader.bloc.dart';

enum FileUploaderPageStatus{ initial,started,failure }
enum FileUploaderAction{none, failure, permissionsDenied, progress, success, progressFailure }
enum FileUploaderStatus{initial,loading,picking,cameraOrGallery,pictureOrVideo,readyToUpload}

final class FileUploaderState extends Equatable{

  FileUploaderState({
    this.pageStatus = FileUploaderPageStatus.initial,
    this.action = FileUploaderAction.none,
    this.status = FileUploaderStatus.initial,
    PermissionsState? permissionsState,
    this.errorMessage = "unknown error",
    this.mediaType = MediaType.none,
    this.sourceType = UploadSourceType.none,
    this.progress=0,
    this.supportedExtensions = const [],
    this.isUploading = false,
    File? file ,
  }): permissionsState = permissionsState ??  PermissionsState(),
    file = file??File("no_path");

  FileUploaderPageStatus pageStatus;
  FileUploaderAction action;
  FileUploaderStatus status;
  PermissionsState permissionsState;
  MediaType mediaType;
  UploadSourceType sourceType;
  String errorMessage;
  File file;
  int progress;
  List<String> supportedExtensions;
  int random = 0;
  bool isUploading;
  //Localization service for translation purpose
  FileUploaderState copyWith({
    FileUploaderPageStatus? pageStatus,
    FileUploaderAction? action,
    FileUploaderStatus? status,
    PermissionsState? permissionsState,
    String? errorMessage,
    UploadSourceType? sourceType,
    MediaType? mediaType,
    File? file,
    int? progress,
    List<String>? supportedExtensions,
    bool? isUploading
  }) {
    return FileUploaderState(
        pageStatus: pageStatus ?? this.pageStatus,
        action: action ?? this.action,
        status: status ?? this.status,
        permissionsState: permissionsState??this.permissionsState,
        errorMessage: errorMessage??this.errorMessage,
        sourceType:sourceType??this.sourceType,
        mediaType: mediaType??this.mediaType,
        file: file??this.file,
        progress: progress??this.progress,
        supportedExtensions:supportedExtensions??this.supportedExtensions,
        isUploading: isUploading??this.isUploading,
    );
  }

  FileUploaderState reset(){
    return FileUploaderState();
  }

  FileUploaderState randomize(){
    random = Random().nextInt(100000);
    return this;
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
  List<Object> get props => [pageStatus,status,permissionsState,errorMessage,sourceType,mediaType,file,progress,random,isUploading];
}