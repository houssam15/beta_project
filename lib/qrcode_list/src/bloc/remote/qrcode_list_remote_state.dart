part of "qrcode_list_remote_bloc.dart";

enum QrcodeListRemoteStatus {
  success,failed,initial
}
class QrcodeListRemoteState extends Equatable {
  QrcodeListRemoteStatus status;
  String errorMessage;
  List<QrcodeItem> items;
  bool hasReachedMax;
  int totalItems;
  int totalItemsByPage;
  int totalInvalidItems;
  bool failedToLoadMoreItems;
  bool showBottomLoader;

  QrcodeListRemoteState({
    this.status = QrcodeListRemoteStatus.initial,
    this.errorMessage = "",
    this.items = const [],
    this.hasReachedMax = false,
    this.totalItemsByPage = 0,
    this.totalItems = 0,
    this.totalInvalidItems = 0,
    this.failedToLoadMoreItems = false,
    this.showBottomLoader = false
  });

  QrcodeListRemoteState copyWith({
    QrcodeListRemoteStatus? status,
    String? errorMessage,
    List<QrcodeItem>? items,
    bool? hasReachedMax,
    int? totalItemsByPage,
    int? totalItems,
    int? totalInvalidItems,
    bool? failedToLoadMoreItems,
    bool? showBottomLoader
  }){
    return QrcodeListRemoteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      items: items ?? this.items,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      totalItemsByPage: totalItemsByPage ?? this.totalItemsByPage,
      totalItems: totalItems ?? this.totalItems,
      totalInvalidItems: totalInvalidItems ?? this.totalInvalidItems,
      failedToLoadMoreItems: failedToLoadMoreItems ?? this.failedToLoadMoreItems,
      showBottomLoader: showBottomLoader ?? this.showBottomLoader
    );
  }

  @override
  List<Object?> get props => [status,errorMessage,items,hasReachedMax,totalItemsByPage,totalItems,totalInvalidItems,failedToLoadMoreItems,showBottomLoader];
}

