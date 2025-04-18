import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/qrcode_list/src/bloc/bloc.dart";
import "package:flutter/material.dart";

class FailedToLoadMoreItems extends StatelessWidget {
  const FailedToLoadMoreItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 5),
          child: Text(context.read<QrcodeListRemoteBloc>().state.errorMessage,style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      ),
    );
  }
}
