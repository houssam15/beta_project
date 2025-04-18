import '../common/common_request.dart';
import "package:social_media_publications_api/social_media_publications_api.dart" as smpa;
import 'package:intl/intl.dart';

extension DatetimeMapping on DateTime?{
  String? getDateForApi(){
    if(this==null) return null;
    return DateFormat('yyyy-MM-dd').format(this!);
  }
}

class GetPublicationsRequest implements CommonRepositoryRequest<smpa.GetPublicationsRequest>{
  final int page;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? query;
  final List<String> accounts;

  GetPublicationsRequest({
      this.page = 1,
      this.fromDate,
      this.toDate,
      this.query,
      this.accounts = const []
  });


  @override
  smpa.GetPublicationsRequest toApiParams() {
    return smpa.GetPublicationsRequest(
      page: page,
      fromDate: fromDate.getDateForApi(),
      toDate: toDate.getDateForApi(),
      query: query?.isEmpty == true || query==null ? null : query,
      accounts: accounts
    );
  }

}