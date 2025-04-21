import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../bloc/remote/qrcode_list_remote_bloc.dart";

class CreatedAt extends StatelessWidget {
  CreatedAt({super.key,required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    QrcodeListRemoteState state = context.read<QrcodeListRemoteBloc>().state;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
          state.items[index].createdAt.formattedDate,
          style: TextStyle(
              color: state.items[index].createdAt.dateColor,
              fontSize: 12
          )
      ),
    );
  }
}
