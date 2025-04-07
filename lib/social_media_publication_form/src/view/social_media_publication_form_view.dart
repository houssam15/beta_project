import "package:alert_banner/types/enums.dart";
import "package:alert_banner/widgets/alert.dart";
import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_list_form/src/social_media_list_form.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";
import "../../../app.dart";
import "../../../home/home_app.dart";
import "../../../social_media_list_form/src/social_media_list_form_arguments.dart";
import "../bloc/remote/social_media_publication_form.remote.bloc.dart";
import "../widgets/widgets.dart";
import "../models/models.dart";
import "social_media_publication_form_failure_page.dart";
import "social_media_publication_form_initial_page.dart";


class SocialMediaPublicationFormView extends StatefulWidget {
  const SocialMediaPublicationFormView({super.key});

  @override
  State<SocialMediaPublicationFormView> createState() => _SocialMediaPublicationFormViewState();
}

class _SocialMediaPublicationFormViewState extends State<SocialMediaPublicationFormView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Container(
            width: double.infinity,
            child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: BlocConsumer<SocialMediaPublicationFormRemoteBloc,SocialMediaPublicationFormRemoteState>(
                    listener: (context, state) async{
                      //Show error message
                      if(state.action == SocialMediaPublicationFormActions.failure){
                          showAlertBanner(context,()=>print("TAPPED"),AlertBannerChild(text: context.tr(state.errorMessage)),alertBannerLocation: AlertBannerLocation.top);
                      }
                      //Show success message
                      if(state.action == SocialMediaPublicationFormActions.success){
                          //showAlertBanner(context,()=>print("TAPPED"),AlertBannerChild(text: context.tr("Succéss !"),color: Colors.green,),alertBannerLocation: AlertBannerLocation.top);
                          //await Future.delayed(Duration(milliseconds: 500));
                          if(navigatorKey.currentContext!=null){
                            Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
                                SocialMediaListForm.route,
                                arguments: SocialMediaListFormArguments(
                                  uploadDocumentResponse:context.read<SocialMediaPublicationFormRemoteBloc>().uploadDocumentResponse.getRepository(),
                                  mediaType: context.read<SocialMediaPublicationFormRemoteBloc>().mediaType.toString(),
                                  constrains: context.read<SocialMediaPublicationFormRemoteBloc>().constrains,
                                  previousState: context.read<SocialMediaPublicationFormRemoteBloc>().state
                                )
                            );
                          }
                      }
                    },
                    builder: (context, state) {
                      switch(state.status){
                        case SocialMediaPublicationFormStatus.initial:
                          return SocialMediaPublicationFormInitialPage(state);
                        case SocialMediaPublicationFormStatus.failure:
                          return SocialMediaPublicationFormFailurePage(state);
                      }
                    },
                  ),
              ),
            ),
        ),
      ),
    );
  }
}



