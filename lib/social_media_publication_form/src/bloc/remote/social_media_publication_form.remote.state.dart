part of 'social_media_publication_form.remote.bloc.dart';

enum SocialMediaPublicationFormStatus {
  initial
}

class SocialMediaPublicationFormRemoteState extends Equatable{

  SocialMediaPublicationFormRemoteState({
    this.status=SocialMediaPublicationFormStatus.initial
  });

  SocialMediaPublicationFormStatus status;

  SocialMediaPublicationFormRemoteState set({
    SocialMediaPublicationFormStatus? status
  }){
    this.status = status ?? this.status;
    return this;
  }

  @override
  List<Object?> get props => [status];

}