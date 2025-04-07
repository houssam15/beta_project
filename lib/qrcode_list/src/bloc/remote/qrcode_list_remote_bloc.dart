import "package:flutter_bloc/flutter_bloc.dart";
import "package:equatable/equatable.dart";

part "qrcode_list_remote_event.dart";
part 'qrcode_list_remote_state.dart';
class QrcodeListRemoteBloc extends Bloc<QrcodeListRemoteEvent,QrcodeListRemoteState>{
  QrcodeListRemoteBloc():super(QrcodeListRemoteState());

}