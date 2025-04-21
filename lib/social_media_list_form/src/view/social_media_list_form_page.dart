import "package:alert_banner/types/enums.dart";
import "package:alert_banner/widgets/alert.dart";
import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/social_media_file_uploader_form_app.dart";
import "package:alpha_flutter_project/social_media_list_form/src/models/models.dart";
import "package:alpha_flutter_project/social_media_publication_form/social_media_publication_form.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";
import "../../../app.dart";
import "../../../home/home_app.dart";
import "../bloc/local/social_media_list_form.local.bloc.dart";
import "../widgets/widgets.dart";
import "../bloc/remote/social_media_list_form.remote.bloc.dart";
class SocialMediaListFormPage extends StatefulWidget {
  const SocialMediaListFormPage({super.key});


  @override
  State<SocialMediaListFormPage> createState() => _SocialMediaListFormPageState();
}

class _SocialMediaListFormPageState extends State<SocialMediaListFormPage> {

  _onResizeFailed(SocialMediaListFormLocalState state){
    showAlertBanner(context,()=>print("TAPPED"),AlertBannerChild(text: context.tr(state.message!),color: Colors.red),alertBannerLocation: AlertBannerLocation.top);
  }

  _onProgressForPublicationFailed(SocialMediaListFormRemoteState state){
    showAlertBanner(context,()=>print("TAPPED"),AlertBannerChild(text: context.tr(state.message),color: Colors.red),alertBannerLocation: AlertBannerLocation.top);
  }

  _onChangeSuccess(SocialMediaListFormLocalState state) async{
    showAlertBanner(context,()=>print("TAPPED"),AlertBannerChild(text: context.tr(state.message!),color: Colors.green),alertBannerLocation: AlertBannerLocation.top);
    state
  }

  _onChangeFailed(SocialMediaListFormLocalState state){
    showAlertBanner(context,()=>print("TAPPED"),AlertBannerChild(text: context.tr(state.message!),color: Colors.grey),alertBannerLocation: AlertBannerLocation.top);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Container(
          width: double.infinity,
          child: Card(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                child: Column(
                    children: [
                      PublishIn(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 16),
                          child: Scrollbar(
                            child: BlocListener<SocialMediaListFormLocalBloc,SocialMediaListFormLocalState>(
                              listener: (context, state) async{
                                  if(state.action == SocialMediaListFormLocalAction.resizeFailed) _onResizeFailed(state);
                                  if(state.action == SocialMediaListFormLocalAction.changeSuccess) await _onChangeSuccess(state);
                                  if(state.action == SocialMediaListFormLocalAction.changeFailed)  _onChangeFailed(state);
                              },
                              child: BlocConsumer<SocialMediaListFormRemoteBloc,SocialMediaListFormRemoteState>(
                                  builder: (context, state) {
                                    switch (state.status){
                                      case SocialMediaListFormRemoteStatus.initial :
                                        //Because BlocListener don't listen to first state
                                        context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormRemoteStarted());
                                        return Text(context.tr("Initial state"));
                                      case SocialMediaListFormRemoteStatus.socialMediaFailed : return ErrorMessageWidget(state.message);
                                      case SocialMediaListFormRemoteStatus.loadingSocialMedia: return LoaderWidget();
                                      case SocialMediaListFormRemoteStatus.socialMediaLoaded: return ListView.separated(
                                        itemCount: state.uploadDocumentResponse!.getNetworks().length,
                                        itemBuilder: (context, index)=>SocialMediaCheckboxWidget(socialMediaItem: state.socialMediaItems[index]),
                                        separatorBuilder: (BuildContext context, int index) {
                                          return Divider(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                          );
                                        },
                                      );
                                    }
                                  },
                                  listener: (context, state) {
                                     if(state.action == SocialMediaListFormRemoteActions.progressForPublicationFailed) _onProgressForPublicationFailed(state);
                                  }
                              ),
                            ),
                          )
                        ),
                      ),
                      BlocBuilder<SocialMediaListFormRemoteBloc,SocialMediaListFormRemoteState>(
                        builder:(context,state) => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyButton(
                              state,
                              onPressed: (){
                                if(navigatorKey.currentContext!=null){
                                  Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
                                      SocialMediaPublicationForm.route,
                                      arguments: SocialMediaPublicationFormArguments(
                                        uploadDocumentResponse: context.read<SocialMediaListFormRemoteBloc>().uploadDocumentResponse.getRepository(),
                                        constrains: context.read<SocialMediaListFormRemoteBloc>().constrains?.getRepository(),
                                        mediaType: context.read<SocialMediaListFormRemoteBloc>().mediaType,
                                        currentState: context.read<SocialMediaListFormRemoteBloc>().previousState
                                      )
                                  );
                                }
                              },
                              title: Text(context.tr("Back"),style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                            ),
                            SizedBox(width: 5,),
                            MyButton(
                              state,
                              onPressed: !state.enableNextAction
                                  ?(){
                                    showAlertBanner(context,()=>print("TAPPED"),AlertBannerChild(text: context.tr("No element selected !"),color: Colors.grey,),alertBannerLocation: AlertBannerLocation.top);
                                  }
                                  :(){
                                     if(state.isPublishing()){
                                       showAlertBanner(context,()=>print("TAPPED"),AlertBannerChild(text: context.tr("Wait please !"),color: Colors.grey,),alertBannerLocation: AlertBannerLocation.top);
                                     }else{
                                       context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormSocialMediaItemsSelected());
                                     }
                              },
                              onPressState:state.isPublishing() ? null : state.enableNextAction,
                              title: state.isPublishing()
                                  ? Loading()
                                  : Text(context.tr("Publish"),style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                            ),

                          ],
                        ),
                      )
                    ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}
