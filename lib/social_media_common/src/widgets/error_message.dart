import "package:flutter/material.dart";

class ErrorMessageWidget extends StatefulWidget {

  ErrorMessageWidget(this.message,{super.key,this.refresh=true,this.onBackToInitialState});

  final String message;
  final bool refresh;
  final void Function()? onBackToInitialState;

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
    widget.onBackToInitialState?.call();
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
