import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/qrcode_list/src/bloc/bloc.dart";
import "package:flutter/material.dart";


class QrcodeListItem extends StatelessWidget {
  QrcodeListItem({super.key,required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        child: Container(
            height: 120,
            decoration: BoxDecoration(
                color: Color(0XFFF3E9E9),
                borderRadius: BorderRadius.circular(6)
            ),
            child: Stack(
                children: [
                  //Created at
                  Align(
                    alignment: Alignment.topRight,

                  )
                ]
            )
        )
    );
  }
}
