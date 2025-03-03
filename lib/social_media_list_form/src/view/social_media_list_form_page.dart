import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_list_form/src/models/models.dart";
import "package:flutter/material.dart";
import "../widgets/widgets.dart";
import "../bloc/remote/social_media_list_form.remote.bloc.dart";
class SocialMediaListFormPage extends StatefulWidget {
  const SocialMediaListFormPage({super.key});

  @override
  State<SocialMediaListFormPage> createState() => _SocialMediaListFormPageState();
}

class _SocialMediaListFormPageState extends State<SocialMediaListFormPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          child: Card(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                        child: Center(
                          child: Text("Publish in :"),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                          child: BlocConsumer<SocialMediaListFormRemoteBloc,SocialMediaListFormRemoteState>(
                              builder: (context, state) {
                                switch (state.status){
                                  case SocialMediaListFormRemoteStatus.initial :
                                    //Because BlocListener don't listen to first state
                                    context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormRemoteStarted());
                                    return Text("Initial state");
                                  case SocialMediaListFormRemoteStatus.socialMediaFailed : return ErrorMessageWidget(state.message);
                                  case SocialMediaListFormRemoteStatus.loadingSocialMedia: return LoaderWidget();
                                  case SocialMediaListFormRemoteStatus.socialMediaLoaded: return ListView.separated(
                                    itemCount: state.socialMediaItems.length,
                                    itemBuilder: (context, index)=>SocialMediaCheckboxWidget(socialMediaItem: state.socialMediaItems[index],index: index),
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
                          )
                        ),
                      ),
                      BlocBuilder<SocialMediaListFormRemoteBloc,SocialMediaListFormRemoteState>(
                        builder:(context,state) => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: !state.enableNextAction?null:(){
                                    context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormSocialMediaItemsSelected());
                                },
                                child: Text("Next"),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateColor.resolveWith((states) {
                                     if(states.contains(WidgetState.disabled)){
                                       return Theme.of(context).colorScheme.secondary;
                                     }
                                     return Theme.of(context).colorScheme.tertiary;
                                  }),
                                ),
                            )
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
