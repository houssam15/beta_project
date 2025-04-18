import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/qrcode_list/src/bloc/bloc.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

import "../../widgets/widgets.dart";

class QrcodeListSuccessPage extends StatelessWidget {
  const QrcodeListSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom:100),
        child: Container(
          width: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.tr("Search")),
                      Text("${context.read<QrcodeListRemoteBloc>().state.totalInvalidItems}")
                    ],
                  ),
                ),
                Expanded(
                    child: context.read<QrcodeListRemoteBloc>().state.items.isEmpty
                        ? QrcodeListEmpty()
                        : QrcodeList()
                )
              ]
          ),
        ),
      ),
    );
  }
}
