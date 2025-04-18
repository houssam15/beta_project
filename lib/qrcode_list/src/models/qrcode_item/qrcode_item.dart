import "dart:core";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:localization_service/localization_service.dart";

import "qrcode_item_link.dart";
import "formatted_date.dart";
import "package:qrcode_list_repository/qrcode_list_repository.dart" as qrlr;

class QrcodeItem{
  String id;
  String qrcodePictureUrl;
  FormattedDate createdAt;
  QrcodeItemLink reviewLink;
  QrcodeItemLink downloadPdfLink;
  QrcodeItemLink downloadPictureLink;
  //Helpers
  static BuildContext? _context;

  static setContext(BuildContext? context){
    _context = context;
  }

  QrcodeItem({
    required this.id,
    required this.createdAt,
    required this.qrcodePictureUrl,
    required this.reviewLink,
    required this.downloadPdfLink,
    required this.downloadPictureLink
  });

  static List<QrcodeItem> toList(List<qrlr.QrcodeItem> data){
    List<QrcodeItem> items = [];
    for(qrlr.QrcodeItem item in data){
      QrcodeItem? elm = QrcodeItem.fromJson(item);
      if(elm!=null) items.add(elm);
    }
    return items;
  }

  static QrcodeItem? fromJson(qrlr.QrcodeItem data){
    try{
      if(_context == null) throw ArgumentError("Context is invalid");
      return QrcodeItem(
        id: data.id,
        qrcodePictureUrl: data.qrcodePicture,
        createdAt: FormattedDate.fromDateTime(data.createdAt, context: _context!),
        reviewLink: QrcodeItemLink(
            url: data.reviewUrl,
            label: _context!.tr("go to review"),
            icon: FontAwesomeIcons.link
        ),
        downloadPictureLink: QrcodeItemLink(
            url: data.downloadPictureUrl,
            icon: FontAwesomeIcons.image,
            label: _context!.tr("download picture"),
        ),
        downloadPdfLink: QrcodeItemLink(
            url: data.downloadPdfUrl,
            icon: FontAwesomeIcons.filePdf,
            label: _context!.tr("download pdf")
        )
      );
    }catch(err){
      return null;
    }
  }
}