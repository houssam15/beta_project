import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:localization_service/localization_service.dart";

import "../../../bloc/remote/qrcode_list_remote_bloc.dart";

class ShareButton extends StatelessWidget {
  ShareButton({super.key,required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    QrcodeListRemoteState state = context.read<QrcodeListRemoteBloc>().state;

    return SizedBox(
      height: 25,
      child: ElevatedButton.icon(
        onPressed: () => context.read<QrcodeListRemoteBloc>().add(QrcodeListRemoteShareRequested(index)),
        label: Text(
            context.tr("Share"),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 12
            )
        ),
        icon: Icon(FontAwesomeIcons.share,size: 12),
        style: ElevatedButton.styleFrom(
            iconColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            padding: EdgeInsets.symmetric(horizontal: 10)
        ),
      ),
    );
  }
}
