import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/file_uploader_app.dart";
import "package:alpha_flutter_project/social_media_list_form/src/models/models.dart";
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
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!)));
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
                              listener: (context, state) {
                                  if(state.action == SocialMediaListFormLocalAction.resizeFailed) _onResizeFailed(state);
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
                                      SocialMediaFileUploaderForm.route
                                  );
                                }
                              },
                              title: Text(context.tr("Back"),style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                            ),
                            SizedBox(width: 5,),
                            MyButton(
                              state,
                              onPressed: !state.enableNextAction ? null : () {
                                context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormSocialMediaItemsSelected());
                              },
                              title: Text(context.tr("Next"),style: TextStyle(color: Theme.of(context).colorScheme.onError)),
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
