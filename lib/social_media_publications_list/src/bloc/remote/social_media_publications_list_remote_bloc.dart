import "dart:math";

import "package:alpha_flutter_project/login/login.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter_date_range_picker/flutter_date_range_picker.dart";
import "package:social_media_publications_repository/social_media_publications_repository.dart" as smpr;
import "../../models/models.dart";
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

part "social_media_publications_list_remote_event.dart";
part "social_media_publications_list_remote_state.dart";

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class SocialMediaPublicationsListRemoteBloc extends Bloc<SocialMediaPublicationsListRemoteEvent,SocialMediaPublicationsListRemoteState>{
  final smpr.SocialMediaPublicationsRepository _socialMediaPublicationsRepository;
  SocialMediaPublicationsListRemoteBloc()
  :_socialMediaPublicationsRepository = smpr.SocialMediaPublicationsRepository()
  ,super(SocialMediaPublicationsListRemoteState()){
   on<SocialMediaPublicationsListRemoteListPublicationsRequested>(_onListPublicationsRequested);
   on<SocialMediaPublicationsListRemotePublicationFetched>(
       _onPublicationFetched,
       transformer: throttleDroppable(throttleDuration),
   );
   on<SocialMediaPublicationsListRemoteSearchFiltersUpdated>(_onSearchFilterUpdated);
  }

  _onListPublicationsRequested(SocialMediaPublicationsListRemoteListPublicationsRequested event,Emitter<SocialMediaPublicationsListRemoteState> emit) async {
    try{
      smpr.GetPublicationsResponse response = await _socialMediaPublicationsRepository.getPublications(smpr.GetPublicationsRequest());
      if(!response.isValid()){
        emit(state.copyWith(status: SocialMediaPublicationsListRemoteStatus.failed,errorMessage: response.getErrorMessage()));
      }else{
        //Initialize context to use LocalizationService for i18n
        SocialMediaPublication.setContext(event.context);
        emit(state.copyWith(
            status: SocialMediaPublicationsListRemoteStatus.success,
            publications: SocialMediaPublication.toList(response.getPublications()),
            totalItems: response.getTotalPublications(),
            totalItemsByPage: response.getTotalItemsByPage(),
            totalInvalidItems: response.getTotalOfInvalidPublications(),
            searchFilters:state.searchFilters.copyWith(accounts: SocialMediaAccount.toList(response.getAccounts()))
        ));
      }
    }catch(err){
      emit(state.copyWith(status: SocialMediaPublicationsListRemoteStatus.failed,errorMessage: "Unexpected error"));
    }
  }

  _onPublicationFetched(SocialMediaPublicationsListRemotePublicationFetched event,Emitter<SocialMediaPublicationsListRemoteState> emit) async {
    try{
      if (state.hasReachedMax) return;
      emit(state.copyWith(showBottomLoader: true));
      if(event.simulateLoading) {
        emit(state.copyWith(status: SocialMediaPublicationsListRemoteStatus.success,failedToLoadMoreItems: false));
        await Future.delayed(Duration(milliseconds: 500));
      }

      smpr.GetPublicationsResponse response = await _socialMediaPublicationsRepository.getPublications(
          smpr.GetPublicationsRequest(
              page: (state.publications.length/state.totalItemsByPage +1).ceil(),
              fromDate: state.searchFilters.dateRange?.start,
              toDate: state.searchFilters.dateRange?.end,
              query: state.searchFilters.query,
              accounts: state.searchFilters.accounts.where((elm)=>elm.isSelected).map<String>((elm)=>elm.id).toList()
          )
      );

      if(!response.isValid()){
        emit(state.copyWith(status: SocialMediaPublicationsListRemoteStatus.success,failedToLoadMoreItems: true,errorMessage: response.getErrorMessage()));
      }else if(state.publications.length>=state.totalItems - state.totalInvalidItems) {
        return emit(state.copyWith(status: SocialMediaPublicationsListRemoteStatus.success,failedToLoadMoreItems: false,hasReachedMax: true));
      }else{
         //Initialize context to use LocalizationService for i18n
        SocialMediaPublication.setContext(event.context);
        //print(state.publications);
        //final xx = response.getPublications();
        //print(xx);
        final newPublications = SocialMediaPublication.toList(response.getPublications());
        emit(
            state.copyWith(
              status: SocialMediaPublicationsListRemoteStatus.success,
              publications: [
                ...state.publications,
                ...newPublications/*.where(
                        (newPub) => !state.publications.any((existing) => existing.id == newPub.id)
                )*/
              ],
              totalItemsByPage: response.getTotalItemsByPage(),
              totalInvalidItems: response.getTotalOfInvalidPublications(),
              failedToLoadMoreItems: false
            )
        );
      }
    }catch(err){
      emit(state.copyWith(status: SocialMediaPublicationsListRemoteStatus.success,failedToLoadMoreItems: true,errorMessage: "Unexpected error"));
    }
    emit(state.copyWith(showBottomLoader: false));
  }


  _onSearchFilterUpdated(SocialMediaPublicationsListRemoteSearchFiltersUpdated event,Emitter<SocialMediaPublicationsListRemoteState> emit) async {
    try{
      emit(
          state.copyWith(searchFilters: state.searchFilters.copyWith(
              query: event.clearFilter ? "": event.query,
              dateRange:event.clearFilter ? null: event.dateRange,
              accounts:event.clearFilter ? SearchFilters.unSelectAllAccounts(state.searchFilters.accounts): state.searchFilters.toggleAccount(event.updatedAccount),
              overrideRangeDate: event.clearFilter ? true:event.overrideRangeDate
          ))
          .forceSend()
      );
      if(!event.fetchData) return;

      smpr.GetPublicationsResponse response = await _socialMediaPublicationsRepository.getPublications(
          smpr.GetPublicationsRequest(
              page: 1,
              fromDate: state.searchFilters.dateRange?.start,
              toDate: state.searchFilters.dateRange?.end,
              query: state.searchFilters.query,
              accounts: state.searchFilters.accounts.where((elm)=>elm.isSelected).map<String>((elm)=>elm.id).toList()
          )
      );

      if(!response.isValid()){
        emit(state.copyWith(status: SocialMediaPublicationsListRemoteStatus.success,failedToLoadMoreItems: true,errorMessage: response.getErrorMessage()));
      }else if(state.publications.length>=state.totalItems - state.totalInvalidItems) {
        return emit(state.copyWith(status: SocialMediaPublicationsListRemoteStatus.success,failedToLoadMoreItems: false,hasReachedMax: true));
      }else{
        //Initialize context to use LocalizationService for i18n
        SocialMediaPublication.setContext(event.context);
        final newPublications = SocialMediaPublication.toList(response.getPublications());
        emit(
            state.copyWith(
                status: SocialMediaPublicationsListRemoteStatus.success,
                publications: newPublications,
                totalItemsByPage: response.getTotalItemsByPage(),
                totalInvalidItems: response.getTotalOfInvalidPublications(),
                failedToLoadMoreItems: false
            )
        );
      }


    }catch(err){

    }
  }


}