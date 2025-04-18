import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "../../../../bloc/remote/social_media_publications_list_remote_bloc.dart";
import "date_input_range_picker.dart";
class DateInput extends StatelessWidget {
  const DateInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialMediaPublicationsListRemoteBloc, SocialMediaPublicationsListRemoteState>(
      builder: (context, state) {
        return Center(
          child: InkWell(
            onTap: () => _showDateDialog(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0XFFFFF3F3),
              ),
              child: const Icon(FontAwesomeIcons.calendar),
            ),
          ),
        );
      },
    );
  }

  void _showDateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        // This ensures the dialog rebuilds when BLoC state changes
        return BlocProvider.value(
          value: BlocProvider.of<SocialMediaPublicationsListRemoteBloc>(context),
          child: DateInputRangePicker(
            onOk: (){
              context.read<SocialMediaPublicationsListRemoteBloc>().add(
                  SocialMediaPublicationsListRemoteSearchFiltersUpdated(
                      context: context,
                      fetchData:true
                  )
              );
            },
            onClear: (){
              context.read<SocialMediaPublicationsListRemoteBloc>().add(
                  SocialMediaPublicationsListRemoteSearchFiltersUpdated(
                      context: context,
                      dateRange: null,
                      fetchData: true,
                      overrideRangeDate: true
                  )
              );
            },
          ),
        );
      },
    );
  }
}


