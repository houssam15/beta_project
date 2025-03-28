import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

class BackConfirmationDialog extends StatelessWidget {
  const BackConfirmationDialog(this.state,{super.key});
  final FileUploaderState state;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Adjust the value as needed
      ),
      title: Text(context.tr("Confirmation")),
      content: Text((context.tr("Are you sure? If you go back, you will lose the picked file."))),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.tr("No")),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(context.tr("Yes"))
        ),
      ],
    );
  }
}
