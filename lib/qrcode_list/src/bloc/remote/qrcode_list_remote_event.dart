part of "qrcode_list_remote_bloc.dart";

sealed class QrcodeListRemoteEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class QrcodeListRemoteItemsRequested extends QrcodeListRemoteEvent{
  final BuildContext context;
  QrcodeListRemoteItemsRequested({required this.context});
}