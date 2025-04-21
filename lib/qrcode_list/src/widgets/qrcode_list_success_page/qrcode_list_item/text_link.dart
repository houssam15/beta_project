import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/qrcode_list/src/bloc/bloc.dart";
import "package:alpha_flutter_project/qrcode_list/src/models/qrcode_item/qrcode_item_link.dart";
import "package:flutter/material.dart";

class TextLink extends StatelessWidget {
  TextLink({required this.index,required this.link,this.onClick});
  int index;
  QrcodeItemLink link;
  void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
                link.icon,color: Theme.of(context).colorScheme.tertiary,
                size: 15,
            ),
            SizedBox(width: 5),
            Container(
              padding: EdgeInsets.only(
                bottom: 1, // This can be the space you need between text and underline
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 1.0, // This would be the width of the underline
                  ))
              ),
              child: Text(
                  link.label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 10
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
