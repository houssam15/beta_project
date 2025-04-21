part of "qrcode_list_remote_bloc.dart";

sealed class QrcodeListRemoteEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class QrcodeListRemoteItemsRequested extends QrcodeListRemoteEvent{
  final BuildContext context;
  QrcodeListRemoteItemsRequested({required this.context});
}

class QrcodeListRemoteOpenReviewLinkRequested extends QrcodeListRemoteEvent{
  final int index;
  QrcodeListRemoteOpenReviewLinkRequested(this.index);
}


class QrcodeListRemoteShareRequested extends QrcodeListRemoteEvent{
  final int index;
  QrcodeListRemoteShareRequested(this.index);
}