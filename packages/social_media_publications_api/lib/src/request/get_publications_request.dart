import "package:dio/dio.dart";

class GetPublicationsRequest {
  final int page;
  final String? query;
  final String? fromDate;
  final String? toDate;
  final List<String> accounts;

  GetPublicationsRequest({
    this.page = 1,
    this.query,
    this.toDate,
    this.fromDate,
    this.accounts = const []

  });


  FormData formatDataForApi(){
    Map<String,dynamic> data = {};
    //Add page
    data.addAll({"page":page});
    if(query != null) data.addAll({"filter[search][query]":query});
    if(fromDate != null) data.addAll({"filter[range][dated_at][from]":fromDate});
    if(toDate != null) data.addAll({"filter[range][dated_at][to]":toDate});
    if(accounts.isNotEmpty){
      accounts.asMap().forEach((index, id) {
        data.addAll({"filter[in][account_id][$index]": id});
      });
    }
    return FormData.fromMap(data);
  }


}