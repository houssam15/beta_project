import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/qrcode_list/src/bloc/bloc.dart";
import "package:alpha_flutter_project/qrcode_list/src/view/pages/qrcode_list_failed_page.dart";
import "package:alpha_flutter_project/qrcode_list/src/view/pages/qrcode_list_initial_page.dart";
import "package:alpha_flutter_project/qrcode_list/src/view/pages/qrcode_list_success_page.dart";
import "package:flutter/material.dart";

class QrcodeListView extends StatefulWidget {
  const QrcodeListView({super.key});

  @override
  State<QrcodeListView> createState() => _QrcodeListViewState();
}

class _QrcodeListViewState extends State<QrcodeListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QrcodeListRemoteBloc,QrcodeListRemoteState>(
        builder:
        (context, state) {
          switch(state.status){
            case QrcodeListRemoteStatus.initial: return QrcodeListInitialPage();
            case QrcodeListRemoteStatus.failed: return QrcodeListFailedPage();
            case QrcodeListRemoteStatus.success: return QrcodeListSuccessPage();
          }
        },
        listener: (context, state) {

        },
    );
  }
}
