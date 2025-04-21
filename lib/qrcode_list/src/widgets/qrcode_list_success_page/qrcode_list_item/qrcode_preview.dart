import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "../../../bloc/remote/qrcode_list_remote_bloc.dart";

class QrcodePreview extends StatelessWidget {
  QrcodePreview({super.key,required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    QrcodeListRemoteState state = context.read<QrcodeListRemoteBloc>().state;

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: 95,
          height: 95,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    state.items[index].downloadPictureLink.url,
                    loadingBuilder: (context, child, loadingProgress){
                      if(loadingProgress == null){
                        return child;
                      }
                      return Center(
                          child: SizedBox(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.tertiary,
                                strokeWidth: 2,
                              )
                          )
                      );
                    },
                    errorBuilder: (context, child, loadingProgress) => Center(
                            child: Icon(
                                FontAwesomeIcons.circleExclamation,
                                color: Theme.of(context).colorScheme.tertiary,
                            )
                    )
                ),
            ),
          ),
        )
    );
  }
}
