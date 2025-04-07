part of 'file_uploader.bloc.dart';

sealed class FileUploaderEvent extends Equatable{
@override
List<Object> get props => [];
}

final class FileUploaderStarted extends FileUploaderEvent{}

final class FileUploaderResetRequested extends FileUploaderEvent{}

final class FileUploaderUploadRequested extends FileUploaderEvent {}

final class FileUploaderSettingsOpened extends FileUploaderEvent {}

final class FileUploaderUploadTypeRequested extends FileUploaderEvent{
  final MediaType mediaType;
  FileUploaderUploadTypeRequested(this.mediaType);

}

final class FileUploaderUploadSourceRequested extends FileUploaderEvent {
  final UploadSourceType uploadSource;
  FileUploaderUploadSourceRequested(this.uploadSource);
}

final class FileUploaderUploadToServer extends FileUploaderEvent {}

final class FileUploaderUploadToServerForNetwork extends FileUploaderEvent {}