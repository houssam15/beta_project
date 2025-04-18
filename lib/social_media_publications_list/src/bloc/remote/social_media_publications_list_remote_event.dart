part of "social_media_publications_list_remote_bloc.dart";

sealed class SocialMediaPublicationsListRemoteEvent extends Equatable{}

class SocialMediaPublicationsListRemoteListPublicationsRequested extends SocialMediaPublicationsListRemoteEvent{
  final BuildContext context;

  SocialMediaPublicationsListRemoteListPublicationsRequested({required this.context});

  @override
  List<Object?> get props => [context];
}

class SocialMediaPublicationsListRemotePublicationFetched extends SocialMediaPublicationsListRemoteEvent{
  final BuildContext context;
  final bool simulateLoading;
  SocialMediaPublicationsListRemotePublicationFetched({required this.context,this.simulateLoading = false});
  @override
  List<Object?> get props => [context,simulateLoading];
}


class SocialMediaPublicationsListRemoteSearchFiltersUpdated extends SocialMediaPublicationsListRemoteEvent{
  String? query;
  DateRange? dateRange;
  SocialMediaAccount? updatedAccount;
  BuildContext context;
  bool fetchData;
  bool overrideRangeDate;
  bool clearFilter;
  SocialMediaPublicationsListRemoteSearchFiltersUpdated({
    this.query,
    this.dateRange,
    this.updatedAccount,
    this.fetchData = true,
    this.overrideRangeDate = false,
    required this.context,
    this.clearFilter = false
  });

  @override
  List<Object?> get props => [query,dateRange,updatedAccount,context,fetchData,overrideRangeDate];
}