import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/models/local_file.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:rive_animated_icon/rive_animated_icon.dart";

import "action_button.dart";

class WarningList extends StatefulWidget {
  const WarningList(this.state,{super.key});
  final FileUploaderState state;

  @override
  State<WarningList> createState() => _WarningListState();
}

class _WarningListState extends State<WarningList> {
  ScrollController _scrollController = ScrollController();
  bool _showArrowDown = true;
  bool _showArrowUp = false;
  bool _isScrollable = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfScrollable();
    });

    _scrollController.addListener(_scrollListener);
  }

  void _checkIfScrollable() {
    if (_scrollController.position.maxScrollExtent > 0) {
      setState(() {
        _isScrollable = true;
        _showArrowDown = true; // Show only the bottom arrow initially
      });
    } else {
      setState(() {
        _isScrollable = false;
        _showArrowDown = false;
        _showArrowUp = false;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels <= 50) {
      // At the top of the list
      setState(() {
        _showArrowUp = false;
        _showArrowDown = true;
      });
    } else if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      // At the bottom of the list
      setState(() {
        _showArrowUp = true;
        _showArrowDown = false;
      });
    } else {
      // In between
      setState(() {
        _showArrowUp = true;
        _showArrowDown = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView.separated(
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => Container( margin:EdgeInsets.all(5),color:Colors.purple.withOpacity(0.05),height: 5),
                //scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: widget.state.uploadDocumentResponse.getWarnings().length,
                itemBuilder: (context, index1) =>
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            //Icons
                            Container(
                              height: 30,
                              child: ListView.builder(
                                itemCount: widget.state.uploadDocumentResponse.getWarnings()[index1].getSocialMediaItem().length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index2) => Container(
                                    margin: EdgeInsets.only(right: 3),
                                    child: Row(
                                      children: [
                                        Icon(
                                            widget.state.uploadDocumentResponse.getWarnings()[index1].getSocialMediaItem()[index2].getIcon(),
                                            color: widget.state.uploadDocumentResponse.getWarnings()[index1].getSocialMediaItem()[index2].getColor()
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                            widget.state.uploadDocumentResponse.getWarnings()[index1].getSocialMediaItem()[index2].getName(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600
                                            ),
                                        )
                                      ],
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            //Messages
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: widget.state.uploadDocumentResponse.getWarnings()[index1].getMessages().length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index2) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("-"),
                                  SizedBox(width: 2,),
                                  Expanded(child: Text(widget.state.uploadDocumentResponse.getWarnings()[index1].getMessages()[index2],softWrap: true))
                                ],
                              ),
                            ),
                            //Actions
                            if(
                                  widget.state.uploadDocumentResponse.getWarnings()[index1].isWarningGlobal()&&
                                  widget.state.mediaType == MediaType.picture&&
                                  widget.state.uploadDocumentResponse.getWarnings()[index1].isNeedRotation()
                            )
                            Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5),
                                        child: InkWell(
                                          onTap: null,
                                          child: Icon(FontAwesomeIcons.rotateLeft,color: Theme.of(context).colorScheme.tertiary,size: 20),
                                        )
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
              ),
              // Top Arrow Indicator
              if (_isScrollable && _showArrowUp)
                Positioned(
                  top: 10,
                  child: Icon(FontAwesomeIcons.angleUp, size: 30, color: Colors.grey.shade400),
                ),
              // Bottom Arrow Indicator
              if (_isScrollable && _showArrowDown)
                Positioned(
                  bottom: 10,
                  child: Icon(FontAwesomeIcons.angleDown, size: 30, color: Colors.grey.shade400),
                ),
            ],
          ),
        )
    );
  }
}
