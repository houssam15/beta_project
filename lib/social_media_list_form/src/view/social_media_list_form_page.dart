import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_list_form/src/models/models.dart";
import "package:flutter/material.dart";
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
            onTap: ()=>Navigator.of(context).pushNamed(HomeApp.route),
            child: Icon(Icons.arrow_back)
        ),
        title: Text(
          "Create publication",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          child: Card(
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                        child: Center(
                          child: Text("publish in"),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 16),
                          child: Scrollbar(
                            child: BlocListener<SocialMediaListFormLocalBloc,SocialMediaListFormLocalState>(
                              listener: (context, state) {
                                  if(state.action == SocialMediaListFormLocalAction.resizeFailed){
                                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!)));
                                  }
                              },
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
                            ElevatedButton(
                              onPressed: !state.enableNextAction ? null : () {
                                context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormSocialMediaItemsSelected());
                              },
                              child: Text(
                                  "Next",
                                  style: TextStyle(
                                    color: !state.enableNextAction
                                        ?Theme.of(context).colorScheme.onPrimary
                                        :Theme.of(context).colorScheme.onError
                                  ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Theme.of(context).colorScheme.secondary; // Color when button is disabled
                                  }
                                  return Theme.of(context).colorScheme.tertiary; // Color when button is enabled
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
