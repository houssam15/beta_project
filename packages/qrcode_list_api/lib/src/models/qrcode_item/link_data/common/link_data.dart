
class LinkData<T extends LinkData<T>> {
  String? url;
  String? _token;

  LinkData({
    this.url
  });

  T setToken(String? token){
    _token = token;
    return this as T;
  }

  String? getToken(){
    return _token;
  }

  factory LinkData.fromJson(Map<String, dynamic> data, {String? token}) {
    throw UnimplementedError('fromJson must be implemented by subclasses');
  }



}