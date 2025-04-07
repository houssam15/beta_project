import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/social_media_file_uploader_form_app.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";
import "../../../app.dart";
import "../../../social_media_file_uploader_form/social_media_file_uploader_form.dart";
import "../bloc/remote/social_media_publication_form.remote.bloc.dart";

class MyActions extends StatelessWidget {
  const MyActions(this.remoteState,{super.key});
  final SocialMediaPublicationFormRemoteState remoteState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            child: Text(
                context.tr("Back"),
                style: TextStyle(
                    fontSize: 10,
                    color:Theme.of(context).colorScheme.onError
                )
            ),
            onPressed:(){
              if(navigatorKey.currentContext!=null){
                Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
                    SocialMediaFileUploaderForm.route,
                    arguments: SocialMediaFileUploaderFormArguments(
                      uploadDocumentResponse: context.read<SocialMediaPublicationFormRemoteBloc>().uploadDocumentResponse.getRepository(),
                      mediaType: context.read<SocialMediaPublicationFormRemoteBloc>().mediaType.toString(),
                      constrains: context.read<SocialMediaPublicationFormRemoteBloc>().constrains,
                      previousState: context.read<SocialMediaPublicationFormRemoteBloc>().state
                    )
                );
              }
            },
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states){
                      if (states.contains(WidgetState.disabled)) {
                        return Colors.grey; // Disabled state
                      }
                      return Theme.of(context).colorScheme.tertiary;                                          }
                )
            ),
          ),
          SizedBox(width: 5),
          ElevatedButton(
            child: Text(
                context.tr("Next"),
                style: TextStyle(
                    fontSize: 10,
                    color:Theme.of(context).colorScheme.onError
                )
            ),
            onPressed:!remoteState.canSubmit()?null:(){
               context.read<SocialMediaPublicationFormRemoteBloc>().add(SocialMediaPublicationFormRemotePublishSubmitted());
            },
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states){
                      if (states.contains(WidgetState.disabled)) {
                        return Colors.grey; // Disabled state
                      }
                      return Theme.of(context).colorScheme.tertiary;                                          }
                )
            ),
          ),

          /*if(_config.prevPageAppRoute!=null)
                    ElevatedButton(
                      child: Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 10,
                              color:Theme.of(context).colorScheme.onError
                          )
                      ),
                      onPressed: (){
                        Navigator.of(context).pushNamed(_config.prevPageAppRoute!);
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                                  (Set<WidgetState> states){
                                if (states.contains(WidgetState.disabled)) {
                                  return Colors.grey; // Disabled state
                                }
                                return Theme.of(context).colorScheme.tertiary;                                          }
                          )
                      ),
                    ),
                  if(_config.nextPageAppRoute!=null)
                    ...[
                      const SizedBox(width: 5),
                      ElevatedButton(
                        child: Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 10,
                                color:Theme.of(context).colorScheme.onError
                            )
                        ),
                        onPressed: (){
                          Navigator.of(context).pushNamed(_config.nextPageAppRoute!);
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                                    (Set<WidgetState> states){
                                  if (states.contains(WidgetState.disabled)) {
                                    return Colors.grey; // Disabled state
                                  }
                                  return Theme.of(context).colorScheme.tertiary; // Enabled state
                                }
                            )
                        ),
                      ),
                    ]*/
        ],
      ),
    );
  }
}
