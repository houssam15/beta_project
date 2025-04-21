import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/qrcode_list/src/bloc/bloc.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:localization_service/localization_service.dart";
import "created_at.dart";
import "share_button.dart";
import "qrcode_preview.dart";
import "text_link.dart";
class QrcodeListItem extends StatelessWidget {
  QrcodeListItem({super.key,required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    QrcodeListRemoteState state = context.read<QrcodeListRemoteBloc>().state;
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
                    child: CreatedAt(index: index)
                  ),

                  //Share button
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: ShareButton(index:index),
                    ),
                  ),

                  //Qrcode preview picture
                  Align(
                    alignment: Alignment.centerLeft,
                    child: QrcodePreview(index:index),
                  ),

                  //Links
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width*2/5,
                      /*decoration: BoxDecoration(
                        color: Colors.grey
                      ),*/
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLink(
                              index:index,
                              link:state.items[index].reviewLink,
                              onClick:  () => context.read<QrcodeListRemoteBloc>().add(QrcodeListRemoteOpenReviewLinkRequested(index))
                          ),
                          TextLink(
                              index:index,
                              link:state.items[index].downloadPdfLink,
                              onClick:  () => context.read<QrcodeListLocalBloc>().add(QrcodeListLocalDownloadPdfRequested(context: context,index: index))
                          ),
                          TextLink(
                              index:index,
                              link:state.items[index].downloadPictureLink,
                              onClick:  () => context.read<QrcodeListLocalBloc>().add(QrcodeListLocalDownloadPictureLinkRequested(index))
                          )
                        ],
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }
}
