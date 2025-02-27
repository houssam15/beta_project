import 'package:flutter_bloc/flutter_bloc.dart';
import "package:equatable/equatable.dart";
part 'social_media_publication_form.remote.event.dart';
part 'social_media_publication_form.remote.state.dart';

class SocialMediaPublicationFormRemoteBloc extends Bloc<SocialMediaPublicationFormRemoteEvent,SocialMediaPublicationFormRemoteState>{

  SocialMediaPublicationFormRemoteBloc():super(SocialMediaPublicationFormRemoteState()){

  }


}