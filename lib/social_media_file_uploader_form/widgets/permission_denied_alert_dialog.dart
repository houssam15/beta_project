import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:localization_service/localization_service.dart";

class PermissionDeniedAlertDialog extends StatefulWidget {
  const PermissionDeniedAlertDialog(this.state,{super.key});
  final FileUploaderState state;

  @override
  State<PermissionDeniedAlertDialog> createState() => _PermissionDeniedAlertDialogState();
}

class _PermissionDeniedAlertDialogState extends State<PermissionDeniedAlertDialog> {

  @override
  void initState() {
    super.initState();
    if(kDebugMode) print(widget.state);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:Text(widget.state.permissionsState.title),
      content: Container(
        //height: 100,
        constraints: BoxConstraints(maxHeight: 200),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.state.permissionsState.message),
            SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.state.permissionsState.permissionsNotRequestedYet.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Icon(Icons.play_arrow,color: Theme.of(context).colorScheme.secondary,size: 20),
                    title: Transform.translate(
                      offset: Offset(-10, 0),
                      child: Text(
                        widget.state.permissionsState.permissionsNotRequestedYet[index],
                        style: TextStyle(fontSize: 13,color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    minLeadingWidth : 20
                  ),
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.tr("cancel"))
        ),
        TextButton(
            onPressed: (){
              context.read<FileUploaderBloc>() .add(FileUploaderSettingsOpened());
              Navigator.of(context).pop();
            },
            child: Text(context.tr("settings"))
        )
      ],
    );
  }
}
