
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
    Constrains? constrains,
    File? file ,
    UploadDocumentResponse? uploadDocumentResponse
  }): permissionsState = permissionsState ??  PermissionsState(),
      constrains = constrains ?? Constrains(),
      uploadDocumentResponse = uploadDocumentResponse ?? UploadDocumentResponse.create(null),
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
  Constrains constrains;
  int random = 0;
  bool isUploading;
  UploadDocumentResponse uploadDocumentResponse;
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
    bool? isUploading,
    Constrains? constrains,
    UploadDocumentResponse? uploadDocumentResponse
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
        constrains: constrains ?? this.constrains,
        uploadDocumentResponse: uploadDocumentResponse ?? this.uploadDocumentResponse
    );
  }

  FileUploaderState reset(){
    return FileUploaderState();
  }

  FileUploaderState randomize(){
    random = Random().nextInt(100000);
    return this;
  }

  @override
  List<Object> get props => [pageStatus,status,permissionsState,errorMessage,sourceType,mediaType,file,progress,random,isUploading,constrains,uploadDocumentResponse];
}