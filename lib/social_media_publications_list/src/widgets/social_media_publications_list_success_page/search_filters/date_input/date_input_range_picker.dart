import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../../../bloc/remote/social_media_publications_list_remote_bloc.dart";
import "package:flutter_date_range_picker/flutter_date_range_picker.dart";

class DateInputRangePicker extends StatelessWidget {
  DateInputRangePicker({super.key,this.onOk,this.onClear});
  void Function()? onOk;
  void Function()? onClear;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialMediaPublicationsListRemoteBloc, SocialMediaPublicationsListRemoteState>(
      builder: (context, state) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero, // Add some padding
          content: Container(
            height: 400,
            child: Column(
              children: [
                Expanded(
                  child: DateRangePickerWidget(
                    doubleMonth: false,
                    maximumDateRangeLength: null,
                    minimumDateRangeLength: 2,
                    initialDateRange: context.read<SocialMediaPublicationsListRemoteBloc>().state.searchFilters.dateRange,
                    onDateRangeChanged: (value) {
                      context.read<SocialMediaPublicationsListRemoteBloc>().add(
                          SocialMediaPublicationsListRemoteSearchFiltersUpdated(
                            context: context,
                            dateRange: value,
                            fetchData:false
                          )
                      );
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          child: Text(
                              "Clear",
                              style: TextStyle(
                                  color: context.read<SocialMediaPublicationsListRemoteBloc>().state.searchFilters.dateRange != null
                                      ? Colors.blue
                                      :Colors.grey
                              )),
                          onPressed: (){
                            onClear?.call();
                            Navigator.of(context).pop();
                          }
                      ),
                      TextButton(
                          child: Text("Ok",style: TextStyle(color: Colors.blue)),
                          onPressed: (){
                            onOk?.call();
                            Navigator.of(context).pop();
                          }
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
