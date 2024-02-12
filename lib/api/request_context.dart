class RequestContext {
  String path;
  String method;
  List<String> queryParams;
  Object? body;
  Map<String, String> headerParams;
  Map<String, String> formParams;
  String? contentType;

  RequestContext(this.path, this.method, this.queryParams, this.body, this.headerParams, this.formParams, this.contentType);
}