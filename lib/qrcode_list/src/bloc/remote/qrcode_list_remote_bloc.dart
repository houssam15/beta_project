import "package:alpha_flutter_project/login/login.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:equatable/equatable.dart";
import "package:qrcode_list_repository/qrcode_list_repository.dart" as qrlr;
import "../../models/models.dart";
part "qrcode_list_remote_event.dart";
part 'qrcode_list_remote_state.dart';
class QrcodeListRemoteBloc extends Bloc<QrcodeListRemoteEvent,QrcodeListRemoteState>{
  final qrlr.QrCodeListRepository _qrCodeListRepository;
  QrcodeListRemoteBloc()
  :_qrCodeListRepository = qrlr.QrCodeListRepository()
  ,super(QrcodeListRemoteState()){
    on<QrcodeListRemoteItemsRequested>(_onItemsRequested);
  }

  _onItemsRequested(QrcodeListRemoteItemsRequested event,Emitter<QrcodeListRemoteState> emit) async{
    try{
      qrlr.GetQrCodeListResponse response = await _qrCodeListRepository.fetchItems(qrlr.GetQrCodeListRequest());
      if(!response.isValid()){
        emit(state.copyWith(status: QrcodeListRemoteStatus.failed,errorMessage: response.getErrorMessage()));
      }else{
        //Initialize context to use LocalizationService for i18n
        QrcodeItem.setContext(event.context);
        emit(state.copyWith(
            status: QrcodeListRemoteStatus.success,
            items: QrcodeItem.toList(response.getItems()),
            totalItems: response.getTotalItems(),
            totalItemsByPage: response.getTotalItemsByPage(),
            totalInvalidItems: response.getTotalOfInvalidItems()
        ));
      }
    }catch(err){
      emit(state.copyWith(status: QrcodeListRemoteStatus.failed,errorMessage: "Unexpected error"));
    }
  }

}