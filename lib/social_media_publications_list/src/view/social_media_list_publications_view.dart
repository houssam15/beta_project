import "package:alpha_flutter_project/social_media_publications_list/src/view/pages/social_media_list_publications_publication_details_page.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "pages/social_media_list_publications_failed_page.dart";
import "pages/social_media_list_publications_initial_page.dart";
import "pages/social_media_list_publications_success_page.dart";
import "../bloc/remote/social_media_publications_list_remote_bloc.dart";

class SocialMediaListPublicationsView extends StatefulWidget {
  const SocialMediaListPublicationsView({super.key});

  @override
  State<SocialMediaListPublicationsView> createState() => _SocialMediaListPublicationsViewState();
}

class _SocialMediaListPublicationsViewState extends State<SocialMediaListPublicationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<SocialMediaPublicationsListRemoteBloc,SocialMediaPublicationsListRemoteState>(
            builder: (context, state) {
              switch(state.status){
                case SocialMediaPublicationsListRemoteStatus.initial: return SocialMediaListPublicationsInitialPage(remoteState: state);
                case SocialMediaPublicationsListRemoteStatus.failed: return SocialMediaListPublicationsFailedPage(remoteState: state);
                case SocialMediaPublicationsListRemoteStatus.success:  return SocialMediaListPublicationsSuccessPage(remoteState: state);
                case SocialMediaPublicationsListRemoteStatus.publicationDetails: return SocialMediaListPublicationsPublicationDetailsPage(remoteState: state);
              }
            },
            listener: (context, state) {

            },
        ),
      ),
    );
  }
}
