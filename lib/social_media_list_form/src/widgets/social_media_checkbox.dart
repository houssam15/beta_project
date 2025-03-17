import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_list_form/src/bloc/local/social_media_list_form.local.bloc.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:image_viewer/image_viewer.dart";
import "../bloc/remote/social_media_list_form.remote.bloc.dart";
import "../models/models.dart";
import "package:image_viewer/image_viewer.dart" as image_viewer;
class SocialMediaCheckboxWidget extends StatefulWidget {
  SocialMediaCheckboxWidget({super.key,required this.socialMediaItem});

  SocialMediaItem socialMediaItem;

  @override
  State<SocialMediaCheckboxWidget> createState() => _SocialMediaCheckboxWidgetState();
}

class _SocialMediaCheckboxWidgetState extends State<SocialMediaCheckboxWidget> {
  //bool _showLoadingForCrop = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                  value: widget.socialMediaItem.isSelected,
                  onChanged: widget.socialMediaItem.hasError()?null:(value) => setState(() {
                        context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormRemoteSocialMediaItemToggled(widget.socialMediaItem,value));
                  })
              ),
              FaIcon( widget.socialMediaItem.icon),
              const SizedBox(width: 5),
              Expanded(
                  child: Wrap(
                    children:[
                      InkWell(
                        onTap:()=>setState(() {
                          widget.socialMediaItem.toggleShowText();
                        }),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.socialMediaItem.title,
                                overflow: widget.socialMediaItem.showText?null:TextOverflow.ellipsis,// Optional: Use this to add '...' if it overflows
                                style: TextStyle(
                                  color:widget.socialMediaItem.hasError()?Theme.of(context).colorScheme.secondary:null,
                                  decoration: widget.socialMediaItem.hasError()?TextDecoration.lineThrough:null,
                                  decorationColor: widget.socialMediaItem.hasError()?Theme.of(context).colorScheme.error:null,
                                  decorationThickness: widget.socialMediaItem.hasError()?2.5:null
                                ),
                              ),
                            ),
                              if(widget.socialMediaItem.hasUrl())
                              ...[
                                InkWell(
                                  onTap: (){
                                    showDialog(context: context, builder: (context) => AlertDialog(content: Container(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      height: MediaQuery.of(context).size.height*0.5,
                                      child:  FutureBuilder(
                                          future: image_viewer.ImageProvider().fromUrl(widget.socialMediaItem.uploadUrl),
                                          builder: (context, snapshot) {
                                            if(snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
                                            if(snapshot.data!.validateResult()==false) return Center(child: Text("can't load picture"));
                                            return ImageViewer(imageProvider: snapshot.data!);
                                          },
                                      ),
                                    ),));
                                  },
                                  child: Container(
                                      padding:EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Icon(Icons.remove_red_eye,color: Theme.of(context).colorScheme.onError)
                                  ),
                                )
                              ],
                              if(widget.socialMediaItem.hasError()&&widget.socialMediaItem.error?.errorType==SocialMediaErrorType.invalidDimensions)
                              ...[
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: (){
                                    context.read<SocialMediaListFormLocalBloc>().add(SocialMediaListFormLocalResizePictureRequested(widget.socialMediaItem,context));
                                  },
                                  child: widget.socialMediaItem.isLoading
                                      ?CircularProgressIndicator()
                                      :Container(
                                        padding:EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8),
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        child: Icon(Icons.crop,color: Theme.of(context).colorScheme.onError)
                                      ),
                                )
                              ]





                          ],
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
          if(widget.socialMediaItem.hasError())
            Container(
              height: (widget.socialMediaItem.error?.getNeededHeightForMessages(multiplayer: 0.9) ?? 0),
              margin: EdgeInsets.only(left: 40),
              constraints: BoxConstraints(maxHeight: 200), // Prevent excessive height
              child: Scrollbar(
                thumbVisibility: true, // Ensures the scrollbar is visible when scrolling
                child: ListView.builder(
                  itemCount: widget.socialMediaItem.error?.messages.length,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "-",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "${widget.socialMediaItem.error?.messages[index]}",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }

}
