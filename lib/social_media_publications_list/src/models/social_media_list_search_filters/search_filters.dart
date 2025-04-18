import "package:flutter_date_range_picker/flutter_date_range_picker.dart";

import "social_media_account.dart";



class SearchFilters{
  String? query;
  DateRange? dateRange;
  List<SocialMediaAccount> accounts;

  SearchFilters({
    this.query,
    this.dateRange,
    this.accounts = const []
  });

  SearchFilters copyWith({
    String? query,
    DateRange? dateRange,
    List<SocialMediaAccount>? accounts,
    bool? overrideRangeDate
  }){
    return SearchFilters(
      query: query ?? this.query,
      dateRange:overrideRangeDate==true ? dateRange : dateRange ?? this.dateRange,
      accounts: accounts ?? this.accounts
    );
  }

  List<SocialMediaAccount> toggleAccount(SocialMediaAccount? account){
    if(account==null) return accounts;
    final index = accounts.indexWhere((elm) => elm.id == account.id);
    if (index == -1) return accounts;
    final updatedAccounts = List<SocialMediaAccount>.from(accounts);
    updatedAccounts[index] = accounts[index].toggleIsSelected();
    return updatedAccounts;
  }

  static List<SocialMediaAccount> unSelectAllAccounts(List<SocialMediaAccount> accounts) {
    for(SocialMediaAccount account in accounts){
      account.isSelected = false;
    }
    return accounts;
  }

}