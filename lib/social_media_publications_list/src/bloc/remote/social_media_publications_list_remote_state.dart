part of "social_media_publications_list_remote_bloc.dart";

enum SocialMediaPublicationsListRemoteStatus {
  initial,//When page loaded first time
  success,//When validation list loaded successfully
  failed,//When validation list don't loaded because of some errors,
  publicationDetails,//When a publication item in list being clicked
}

class SocialMediaPublicationsListRemoteState extends Equatable{
  SocialMediaPublicationsListRemoteState({
     this.status = SocialMediaPublicationsListRemoteStatus.initial,
     this.errorMessage = "",
     this.publications = const [],
     this.hasReachedMax = false,
     this.totalItemsByPage = 0,
     this.totalItems = 0,
     this.totalInvalidItems = 0,
     this.failedToLoadMoreItems = false
  });

  //Page status
  SocialMediaPublicationsListRemoteStatus status;
  //Failed status error message
  String errorMessage;
  List<SocialMediaPublication> publications;
  bool hasReachedMax;
  int totalItems;
  int totalItemsByPage;
  int totalInvalidItems;
  bool failedToLoadMoreItems;

  SocialMediaPublicationsListRemoteState copyWith({
      SocialMediaPublicationsListRemoteStatus? status,
      String? errorMessage,
      List<SocialMediaPublication>? publications,
      bool? hasReachedMax,
      int? totalItemsByPage,
      int? totalItems,
      int? totalInvalidItems,
      bool? failedToLoadMoreItems
  }){
    return SocialMediaPublicationsListRemoteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      publications: publications ?? this.publications,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      totalItemsByPage: totalItemsByPage ?? this.totalItemsByPage,
      totalItems: totalItems ?? this.totalItems,
      totalInvalidItems: totalInvalidItems ?? this.totalInvalidItems,
      failedToLoadMoreItems: failedToLoadMoreItems ?? this.failedToLoadMoreItems
    );
  }

  @override
  List<Object?> get props => [status,errorMessage,publications,hasReachedMax,totalItemsByPage,totalItems,totalInvalidItems,failedToLoadMoreItems];
}