import 'dart:convert' as convert;

import 'package:flutter_task_manager/services/api/index.dart';
import 'package:flutter_task_manager/services/log/logger.dart';

class ApiResult {
  dynamic data;
  BaseApiException? exception;
  bool wasSuccessful;

  ApiResult(this.wasSuccessful, {this.data, this.exception});

  bool isException() {
    return this.wasSuccessful ? false : true;
  }

  bool hasData() {
    return this.wasSuccessful ? true : false;
  }

  static ok(dynamic data) {
    return new ApiResult(true, data: data, exception: null);
  }

  static fail(BaseApiException exception) {
    final apiResult = new ApiResult(false, data: null, exception: exception);

    final logger = Logger("ApiResult");
    logger.error("fail", apiResult: apiResult);
    return apiResult;
  }

  Map<String, dynamic> toJson() {
    return {
      "data": convert.jsonEncode(data),
      "exception": exception.toString(),
    };
  }

  @override
  String toString() {
    return convert.jsonEncode(this.toJson()).toString();
  }
}
