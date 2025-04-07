abstract class DataState<T> {
  final T ? data;
  final String ? error;
  final String ? details;

  const DataState({this.data, this.error,this.details});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data,{String? details}) : super(data: data,details: details);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String  error,{String? details}) : super(error: error,details: details);
}