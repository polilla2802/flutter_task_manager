import 'package:flutter_task_manager/services/api/base_api_exception.dart';

enum ApiChannel { nextline, urlencoded, undefined }

String getApiChannelKey(ApiChannel api) {
  switch (api) {
    case ApiChannel.nextline:
      return "nextline";
    case ApiChannel.urlencoded:
      return "urlencoded";
    case ApiChannel.undefined:
    default:
      return "undefined";
  }
}

enum AuthType { bearer, soft }

class ApiRequest {
  ApiChannel api;
  String key;
  String uri;
  Map<String, dynamic>? body;
  Map<String, dynamic>? queryParameters;
  AuthType authType;

  ApiRequest(this.api, this.key, this.uri, this.authType,
      {this.body, this.queryParameters});
}
