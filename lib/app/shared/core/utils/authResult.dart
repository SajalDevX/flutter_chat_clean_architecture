import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class ErrorState<T> {
  final Exception? clientError;
  final Exception? parseError;
  final HttpException? httpError;
  final NetworkException? networkError;

  const ErrorState(
      {this.clientError, this.networkError, this.httpError, this.parseError});

  parse({
    Function(Exception)? onClientError,
    Function(Exception)? onParseError,
    Function(HttpException)? onHttpError,
    Function(NetworkException)? onNetworkError,
  }) {
    if (clientError != null) onClientError!(clientError!);
    if (parseError != null) onParseError!(parseError!);
    if (httpError != null) onHttpError!(httpError!);
    if (networkError != null) onNetworkError!(networkError!);
  }
}

class DataClientError<T> extends ErrorState<T> {
  DataClientError(Exception error) : super(clientError: error) {
    log('DataClientError: Unable to parse the json', error: error);
  }
}

class DataNetworkError<T> extends ErrorState<T> {
  DataNetworkError(NetworkException error, Response? response)
      : super(networkError: error) {
    log('$error: Unable to parse the json', error: response?.data);
    // print(response?.data);
  }
}

class DataHttpError<T> extends ErrorState<T> {
  DataHttpError(HttpException error) : super(httpError: error) {
    log('DataHttpError: Unable to parse the json', error: error);
  }
}

class DataParseError<T> extends ErrorState<T> {
  DataParseError(Exception error) : super(parseError: error) {
    log('DataParseError: Unable to parse the json', error: error);
  }
}
enum NetworkException { noInternetConnection, timeOutError, unknown }
