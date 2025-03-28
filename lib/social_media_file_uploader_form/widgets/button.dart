import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

class MyButton extends StatefulWidget {
  MyButton(
      this.state, {
      super.key,
      this.onPressed,
      required this.title,
      this.activeColor,
      this.disableColor
  });

  final FileUploaderState state;
  final void Function()? onPressed;
  final Widget title;
  final Color? activeColor;
  final Color? disableColor;

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
          if (states.contains(MaterialState.disabled)) {
            return widget.disableColor ??Theme.of(context).colorScheme.secondary;
          } else {
            return widget.activeColor ?? Theme.of(context).colorScheme.tertiary;
          }
        }),
      ),
    );
  }
}
