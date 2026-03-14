import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:learnex/core/network/results.dart';

/// A safe wrapper for making asynchronous API calls.
///
/// It handles various exceptions like [DioException], [SocketException],
/// and other common errors, returning a [Results] object ([Success] or [Failure]).
Future<Results<T>> safeCall<T>(Future<Results<T>> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    return _handleDioException(e);
  } on SocketException catch (e) {
    return Failure(
      message: 'No internet connection. Please check your network.',
      exception: e,
    );
  } on FormatException catch (e) {
    return Failure(
      message: 'Error parsing data. Please try again later.',
      exception: e,
    );
  } on TypeError catch (e) {
    return Failure(
      message: 'There was an issue with the data format.',
      exception: e as Exception,
    );
  } catch (e) {
    return Failure(
      message: 'An unexpected error occurred. Please try again.',
      exception: e is Exception ? e : Exception(e.toString()),
    );
  }
}

/// Handles different types of [DioException] and returns a corresponding [Failure].
Failure<T> _handleDioException<T>(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return Failure(
        message: 'Connection timed out. Please try again.',
        exception: e,
      );

    case DioExceptionType.badResponse:
      final statusCode = e.response?.statusCode;
      // Attempt to get a more specific error message from the response body.
      String serverMessage =
          _extractErrorMessage(e.response?.data) ??
          e.message ??
          'An error occurred.';

      if (statusCode == 401) {
        return Failure(message: 'Unauthorized: $serverMessage', exception: e);
      }
      if (statusCode == 404) {
        return Failure(message: 'Resource not found.', exception: e);
      }
      if (statusCode != null && statusCode >= 500) {
        return Failure(message: 'Server Error: $serverMessage', exception: e);
      }
      return Failure(message: 'Error: $serverMessage', exception: e);

    case DioExceptionType.cancel:
      return Failure(message: 'Request was cancelled.', exception: e);

    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
    default:
      if (e.error is SocketException) {
        return Failure(
          message: 'No internet connection. Please check your network.',
          exception: e,
        );
      }
      return Failure(
        message: 'A network error occurred. Please try again.',
        exception: e,
      );
  }
}

/// Attempts to extract a meaningful error message from the server's response data.
String? _extractErrorMessage(dynamic data) {
  if (data == null) return null;
  // APIs often return errors in a JSON object like:
  // { "message": "Error details" } or { "error": "Error details" }
  if (data is Map) {
    if (data.containsKey('message')) return data['message'];
    if (data.containsKey('error')) return data['error'];
  }
  // If the data is just a string, return it directly.
  if (data is String) {
    return data;
  }
  return null;
}
