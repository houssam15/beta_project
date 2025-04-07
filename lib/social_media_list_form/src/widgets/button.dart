import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

import "../bloc/remote/social_media_list_form.remote.bloc.dart";

class MyButton extends StatefulWidget {
  MyButton(
      this.state, {
      super.key,
      this.onPressed,
      required this.title,
      this.activeColor,
      this.disableColor,
      this.onPressState
  });

  final SocialMediaListFormRemoteState state;
  final void Function()? onPressed;
  final Widget title;
  final Color? activeColor;
  final Color? disableColor;
  final bool? onPressState;
  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: widget.title,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if(widget.onPressState==null){
                if (states.contains(MaterialState.disabled)) {
                  return widget.disableColor ??Theme.of(context).colorScheme.secondary;
                } else {
                  return widget.activeColor ?? Theme.of(context).colorScheme.tertiary;
                }
          }else if(widget.onPressState==true){
                return widget.activeColor ?? Theme.of(context).colorScheme.tertiary;
          }else{
                return widget.disableColor ?? Theme.of(context).colorScheme.secondary;
          }

        }),
      ),
    );
  }
}
