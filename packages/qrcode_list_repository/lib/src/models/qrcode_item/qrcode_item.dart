import "package:qrcode_list_api/qrcode_list_api.dart" as qrla;
class QrcodeItem{
  String id;
  String qrcodePicture;
  DateTime createdAt;
  String reviewUrl;
  String downloadPdfUrl;
  String downloadPictureUrl;

  QrcodeItem({
    required this.id,
    required this.createdAt,
    required this.qrcodePicture,
    required this.reviewUrl,
    required this.downloadPdfUrl,
    required this.downloadPictureUrl
  });


  static List<QrcodeItem> toList(List<qrla.QrcodeItem> data) {
    List<QrcodeItem> items = [];
    for(qrla.QrcodeItem item in data){
      QrcodeItem? elm = QrcodeItem.fromJson(item);
      if(elm!=null) items.add(elm);
    }
    return items;
  }

  static QrcodeItem? fromJson(qrla.QrcodeItem data){
    try{
      return QrcodeItem(
        id: data.id.toString(),
        createdAt: DateTime.parse(data.createdAt.toString()),
        qrcodePicture:  data.picture!.url!,
        reviewUrl: data.link!,
        downloadPictureUrl: data.picture!.url!,
        downloadPdfUrl: data.pdf!.url!,
      );
    }catch(err){
      return null;
    }
  }
}