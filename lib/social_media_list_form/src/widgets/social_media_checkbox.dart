import "package:alert_banner/types/enums.dart";
import "package:alert_banner/widgets/alert.dart";
import "package:alpha_flutter_project/app.dart";
import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_list_form/src/bloc/local/social_media_list_form.local.bloc.dart";
import "package:alpha_flutter_project/social_media_list_form/src/widgets/error_list_tile.dart";
import "package:alpha_flutter_project/social_media_list_form/src/widgets/flex_text.dart";
import "package:alpha_flutter_project/social_media_list_form/src/widgets/my_icon.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:image_viewer/image_viewer.dart";
import "package:localization_service/localization_service.dart";
import "../bloc/remote/social_media_list_form.remote.bloc.dart";
import "../models/models.dart";
import "package:image_viewer/image_viewer.dart" as image_viewer;
import "alert_banner_child.dart";
class SocialMediaCheckboxWidget extends StatefulWidget {
  SocialMediaCheckboxWidget({super.key,required this.socialMediaItem});
  final SocialMediaItem socialMediaItem;
  @override
  State<SocialMediaCheckboxWidget> createState() => _SocialMediaCheckboxWidgetState();
}
class _SocialMediaCheckboxWidgetState extends State<SocialMediaCheckboxWidget> {
  ScrollController _scrollController = ScrollController();
  _onViewPicture(){
    showDialog(context: context, builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Change this value
      ),
      content: Container(
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.5,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child:  FutureBuilder(
        future: image_viewer.ImageProvider().fromUrl(widget.socialMediaItem.uploadUrl),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
          if(snapshot.data!.validateResult()==false) return Center(child: Text(context.tr("can't load picture")));
          return ImageViewer(imageProvider: snapshot.data!);
        },
      ),
    ),));
  }

  _onCrop(){
    context.read<SocialMediaListFormLocalBloc>().add(SocialMediaListFormLocalResizePictureRequested(widget.socialMediaItem,context));
  }

  _onChange(){
    context.read<SocialMediaListFormLocalBloc>().add(SocialMediaListFormLocalUploadPictureRequested(widget.socialMediaItem,navigatorKey.currentContext));
  }

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
                  onChanged: widget.socialMediaItem.hasError()
                      ?(value){
                          showAlertBanner(context,()=>print("TAPPED"),AlertBannerChild(text: context.tr("Please fix the errors before selecting this option."),color: Colors.grey,),alertBannerLocation: AlertBannerLocation.top);
                      }
                      :(value){
                          if(context.read<SocialMediaListFormRemoteBloc>().state.isPublishing()){
                            showAlertBanner(context,()=>print("TAPPED"),AlertBannerChild(text: context.tr("Wait please !"),color: Colors.grey,),alertBannerLocation: AlertBannerLocation.top);
                          }else{
                            context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormRemoteSocialMediaItemToggled(widget.socialMediaItem,value));
                          }
                  },
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (widget.socialMediaItem.hasError()) {
                      return Colors.grey; // Grey when disabled
                    }
                    return Theme.of(context).colorScheme.tertiary; // Default color
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
                            FlexText(widget.socialMediaItem),
                            if(widget.socialMediaItem.hasUrl())
                              MyIcon(icon: Icons.remove_red_eye,onTap: _onViewPicture),
                            if(widget.socialMediaItem.hasError()&&widget.socialMediaItem.error?.errorType==SocialMediaErrorType.invalidDimensions)
                              MyIcon(icon: Icons.crop,onTap: _onCrop),
                            if(widget.socialMediaItem.hasError()&&widget.socialMediaItem.error?.errorType==SocialMediaErrorType.invalidFile)
                              MyIcon(icon: FontAwesomeIcons.arrowUpFromBracket,onTap: _onChange)
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
                controller: _scrollController,
                thumbVisibility: true, // Ensures the scrollbar is visible when scrolling
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.socialMediaItem.error?.messages.length,
                  itemBuilder: (context, index) => ErrorListTile(widget.socialMediaItem.error?.messages[index]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
