import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:flutter/material.dart";
import "../bloc/remote/social_media_publication_form.remote.bloc.dart";
import "../widgets/widgets.dart";
import "package:flutter/cupertino.dart";

class SocialMediaPublicationFormInitialPage extends StatefulWidget {
  const SocialMediaPublicationFormInitialPage(this.remoteState,{super.key});
  final SocialMediaPublicationFormRemoteState remoteState;
  @override
  State<SocialMediaPublicationFormInitialPage> createState() => _SocialMediaPublicationFormInitialPageState();
}

class _SocialMediaPublicationFormInitialPageState extends State<SocialMediaPublicationFormInitialPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.remoteState.title);
    descriptionController = TextEditingController(text: widget.remoteState.description);
  }

  _onTitleOrDescriptionChanged(){
    context.read<SocialMediaPublicationFormRemoteBloc>().add(SocialMediaPublicationFormRemoteTitleOrDescriptionChanged(
      titleController.text,
      descriptionController.text
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            MyTitle(widget.remoteState),
            MyTextField(widget.remoteState,hintText: "Enter title here ...", labelText: "title",controller: titleController,onChanged:_onTitleOrDescriptionChanged),
            MyTextField(widget.remoteState,hintText: "Enter description here ...", labelText: "description",controller: descriptionController,onChanged: _onTitleOrDescriptionChanged),
            PublishNow(widget.remoteState),
            PublishLater(widget.remoteState),
            if(widget.remoteState.showPublishCalendar())
              ...[
                SelectPublishDate(widget.remoteState),
                CalendarDatePickerWidget(widget.remoteState),
                SelectPublishTime(widget.remoteState),
                TimePicker(widget.remoteState)
              ],

            MyActions(widget.remoteState)
          ]
      ),
    );
  }
}
