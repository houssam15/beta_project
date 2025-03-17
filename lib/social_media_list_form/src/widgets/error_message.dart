import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_list_form/src/bloc/remote/social_media_list_form.remote.bloc.dart";
import "package:flutter/material.dart";

class ErrorMessageWidget extends StatefulWidget {

  ErrorMessageWidget(this.message,{super.key,this.refresh=true});

  final String message;
  final bool refresh;

  @override
  State<ErrorMessageWidget> createState() => _ErrorMessageWidgetState();
}

class _ErrorMessageWidgetState extends State<ErrorMessageWidget> {
  bool expandText = false;

  toggleText(){
    setState(() {
      expandText = !expandText;
    });
  }

  backToInitialState(){
    context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormRemoteStarted());
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: toggleText,
              child: Text(widget.message,overflow: expandText?null:TextOverflow.ellipsis,textAlign: TextAlign.center,)
            ),
            if(widget.refresh)...[
              SizedBox(height: 5),
              InkWell(
                onTap: backToInitialState,
                child: Icon(Icons.refresh),
              )
            ]
          ],
    ));
  }
}
