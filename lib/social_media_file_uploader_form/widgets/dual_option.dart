import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

import "widgets.dart";



class DualOption extends StatelessWidget {
  final FileUploaderState state;
  final void Function()? option1Action;
  final String option1Title;
  final IconData option1Icon;
  final void Function()? option2Action;
  final String option2Title;
  final IconData option2Icon;
  final String title;
  final Widget? actions;
  DualOption(
     this.state,
     {
       required this.title,
       required this.option1Action,
       required this.option1Icon,
       required this.option1Title,
       required this.option2Action,
       required this.option2Icon,
       required this.option2Title,
       this.actions
     }
  );

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(child: Text(title,style: Theme.of(context).textTheme.titleSmall)),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconWithTitle(
                                onTap: option1Action,
                                icon: option1Icon,
                                title: option1Title
                            ),
                            SizedBox(width: 10),
                            Text(context.tr("or"),style: Theme.of(context).textTheme.titleSmall),
                            SizedBox(width: 10),
                            IconWithTitle(
                                onTap:option2Action,
                                icon: option2Icon,
                                title: option2Title
                            )
                          ],
                        ),
                      ],
                    ),
                  )
              ),
              if(actions != null)
              Container(
                padding: EdgeInsets.all(8),
                child: actions,
              )

            ],
          ),
        )
    );
  }
}
