import "package:flutter_bloc/flutter_bloc.dart";
import "package:equatable/equatable.dart";

part "qrcode_list_local_event.dart";
part 'qrcode_list_local_state.dart';
class QrcodeListLocalBloc extends Bloc<QrcodeListLocalEvent,QrcodeListLocalState>{
  QrcodeListLocalBloc():super(QrcodeListLocalState());

}