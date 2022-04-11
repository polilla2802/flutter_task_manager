import 'package:flutter/material.dart';

enum Environment { production, development }

String getEnvironmentValue(Environment? environment) {
  switch (environment) {
    case Environment.development:
      return "development";
    case Environment.production:
      return "production";
    default:
      return "undefined";
  }
}

BuildEnvironment? get environment => _environment;
BuildEnvironment? _environment;

class BuildEnvironment {
  final Environment? env;

  final String? apiBaseAddress;
  final String? bearer;

  /// The defaultLanguage Locale is added for development tools to change the
  /// language programmatically. Here you can change the Locale to change the
  /// whole app's language.
  final Locale? defaultLanguage;
  final String? secretKey;

  BuildEnvironment._init(
      {this.env,
      this.apiBaseAddress,
      this.defaultLanguage,
      this.secretKey,
      this.bearer});

  static void init(
          {required env,
          required apiBaseAddress,
          required defaultLanguage,
          required secretKey,
          required bearer}) =>
      _environment ??= BuildEnvironment._init(
          env: env,
          apiBaseAddress: apiBaseAddress,
          defaultLanguage: defaultLanguage,
          secretKey: secretKey,
          bearer: bearer);

  @override
  String toString() {
    return _toJson().toString();
  }

  Map<String, dynamic> _toJson() => {
        "env": env,
        "apiBaseAddress": apiBaseAddress,
        "defaultLanguage": defaultLanguage,
        "secretKey": secretKey,
        "bearer": bearer
      };
}
