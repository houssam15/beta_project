import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";
import "../bloc/remote/social_media_list_form.remote.bloc.dart";

class NextButton extends StatelessWidget {
  NextButton(this.state,{super.key});
  final SocialMediaListFormRemoteState state;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: !state.enableNextAction ? null : () {
        context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormSocialMediaItemsSelected());
      },
      child: Text(
        context.tr("Next"),
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
    );
  }
}
