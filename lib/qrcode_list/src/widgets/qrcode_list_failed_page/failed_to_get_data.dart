import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/qrcode_list/src/bloc/remote/qrcode_list_remote_bloc.dart";
import "package:flutter/material.dart";


class FailedToGetData extends StatelessWidget {
  const FailedToGetData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/common/error.png"),
          SizedBox(height: 20),
          Text(context.read<QrcodeListRemoteBloc>().state.errorMessage)
        ]
    );
  }
}
