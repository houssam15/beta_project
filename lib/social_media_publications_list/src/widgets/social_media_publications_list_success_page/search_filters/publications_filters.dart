import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_publications_list/src/bloc/bloc.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'text_field.dart';
import 'date_input/date_input.dart';
class PublicationsFilter extends StatefulWidget {
  const PublicationsFilter({super.key});

  @override
  State<PublicationsFilter> createState() => _PublicationsFilterState();
}

class _PublicationsFilterState extends State<PublicationsFilter> {
  late TextEditingController queryController;
  bool showFilters = false;

  @override
  void initState() {
    super.initState();
    queryController = TextEditingController(text: context.read<SocialMediaPublicationsListRemoteBloc>().state.searchFilters.query);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 10),
      child: Column(
        children: [
          //Search filter header
          ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){
                        context.read<SocialMediaPublicationsListRemoteBloc>().add(
                          SocialMediaPublicationsListRemoteSearchFiltersUpdated(
                            context: context,
                            clearFilter: true,
                            fetchData: true
                          )
                        );
                        queryController.text = "";
                        showFilters = false;
                        setState(() {

                        });
                    },
                    icon: Icon(
                      FontAwesomeIcons.rotate,
                      color: Colors.black,
                      size: 15,
                    )
                ),
                IconButton(
                    onPressed: (){
                       setState(() {
                         showFilters = !showFilters;
                       });
                    },
                    icon: Icon(
                      showFilters ? FontAwesomeIcons.x:FontAwesomeIcons.magnifyingGlass,
                      color: Colors.black,
                      size: 15,
                    )
                ),
              ],
            )
          ],
          if(showFilters)
          //Filters
          ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: MyTextField(
                      hintText: "search by title,description...",
                      labelText: "Search",
                      controller: queryController,
                      onChanged: (){
                        context.read<SocialMediaPublicationsListRemoteBloc>().add(SocialMediaPublicationsListRemoteSearchFiltersUpdated(
                            query: queryController.text,
                            context: context
                        ));
                      },
                    )
                ),
                SizedBox(width: 10),
                DateInput()
              ],
            ),
            Wrap(
              spacing: 2.0,
              runSpacing: 2,
              children: context.read<SocialMediaPublicationsListRemoteBloc>().state.searchFilters.accounts.map(
                    (elm) => ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(elm.engineIcon, color: elm.engineColor, size: 16),
                        SizedBox(width: 4),
                        Text(elm.title),
                      ],
                    ),
                    selected: elm.isSelected,
                    onSelected: (value) {
                      context.read<SocialMediaPublicationsListRemoteBloc>().add(SocialMediaPublicationsListRemoteSearchFiltersUpdated(
                          updatedAccount: elm,
                          context: context
                      ));
                    },
                    side: BorderSide(
                        color: Colors.transparent
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    labelStyle: TextStyle(
                      color: elm.isSelected ? elm.engineColor : Colors.grey[600],
                      fontWeight: elm.isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    avatar: elm.isSelected? Icon(Icons.check, color: Colors.white,size: 18): null
                ),
              ).toList(),
            )
          ]

        ],
      ),
    );
  }
}
