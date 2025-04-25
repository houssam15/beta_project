abstract class UploadResponse {
  UploadResponse fromJson(Map<String, dynamic> json, {String? token});
  List<String> getErrors();
  void addErrors(List<String> errors);
}