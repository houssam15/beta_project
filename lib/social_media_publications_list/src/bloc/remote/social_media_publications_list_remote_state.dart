part of "social_media_publications_list_remote_bloc.dart";

enum SocialMediaPublicationsListRemoteStatus {
  initial,//When page loaded first time
  success,//When validation list loaded successfully
  failed,//When validation list don't loaded because of some errors
  publicationDetails,//When a publication item in list being clicked
}
class SocialMediaPublicationsListRemoteState extends Equatable{
  SocialMediaPublicationsListRemoteState({
     this.status = SocialMediaPublicationsListRemoteStatus.initial,
     this.errorMessage = ""
  });

  //Page status
  SocialMediaPublicationsListRemoteStatus status;
  //Failed status error message
  String errorMessage;

  SocialMediaPublicationsListRemoteState copyWith({
      SocialMediaPublicationsListRemoteStatus? status,
      String? errorMessage
  }){
    return SocialMediaPublicationsListRemoteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status,errorMessage];
}