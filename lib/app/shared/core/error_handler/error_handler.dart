import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:talker/talker.dart';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../dev_tools/del_tools.dart';
import '../inject_dependency/dependencies.dart';
import '../utils/authResult.dart';

// Add this to handle Firebase authentication errors
enum FirebaseAuthError {
  emailAlreadyInUse,
  weakPassword,
  invalidEmail,
  userNotFound,
  wrongPassword,
  tooManyRequests,
  operationNotAllowed,
  unknown
}

class ErrorHandler {
  static Future<bool> _isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Firebase-specific error handling method
  static FirebaseAuthError mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return FirebaseAuthError.emailAlreadyInUse;
      case 'weak-password':
        return FirebaseAuthError.weakPassword;
      case 'invalid-email':
        return FirebaseAuthError.invalidEmail;
      case 'user-not-found':
        return FirebaseAuthError.userNotFound;
      case 'wrong-password':
        return FirebaseAuthError.wrongPassword;
      case 'too-many-requests':
        return FirebaseAuthError.tooManyRequests;
      case 'operation-not-allowed':
        return FirebaseAuthError.operationNotAllowed;
      default:
        return FirebaseAuthError.unknown;
    }
  }

  // Error handling for Firebase email/password login and signup
  static Future<Either<ErrorState, T>> callFirebaseAuth<T>(
      Future<T> Function() firebaseAuthConnect,
      ) async {
    try {
      final result = await firebaseAuthConnect();
      return right(result);
    } on FirebaseAuthException catch (e) {
      final firebaseError = mapFirebaseAuthError(e);
      switch (firebaseError) {
        case FirebaseAuthError.emailAlreadyInUse:
          return left(DataClientError(Exception('Email already in use')));
        case FirebaseAuthError.weakPassword:
          return left(DataClientError(Exception('Weak password')));
        case FirebaseAuthError.invalidEmail:
          return left(DataClientError(Exception('Invalid email')));
        case FirebaseAuthError.userNotFound:
          return left(DataHttpError(HttpException('User not found')));
        case FirebaseAuthError.wrongPassword:
          return left(DataHttpError(HttpException('Incorrect password')));
        case FirebaseAuthError.tooManyRequests:
          return left(DataHttpError(HttpException('Too many requests, try again later')));
        case FirebaseAuthError.operationNotAllowed:
          return left(DataHttpError(HttpException('Operation not allowed')));
        default:
          return left(DataHttpError(HttpException('Unknown Firebase error')));
      }
    } catch (e, s) {
      sl<Talker>().logTyped(SupabaseLogger(e.toString(), s, e));
      return left(DataHttpError(HttpException('Unknown error occurred')));
    }
  }

  // Error handling for Firebase phone authentication
  static Future<Either<ErrorState, T>> callFirebasePhoneAuth<T>(
      Future<T> Function() firebaseAuthConnect,
      ) async {
    try {
      final result = await firebaseAuthConnect();
      return right(result);
    } on FirebaseAuthException catch (e) {
      final firebaseError = mapFirebaseAuthError(e);
      switch (firebaseError) {
        case FirebaseAuthError.tooManyRequests:
          return left(DataHttpError(HttpException('Too many requests, try again later')));
        case FirebaseAuthError.operationNotAllowed:
          return left(DataHttpError(HttpException('Phone auth not allowed')));
        default:
          return left(DataHttpError(HttpException('Unknown phone auth error')));
      }
    } catch (e, s) {
      sl<Talker>().logTyped(SupabaseLogger(e.toString(), s, e));
      return left(DataHttpError(HttpException('Unknown error occurred during phone auth')));
    }
  }
  static Future<Either<ErrorState, T>> callApi<T>(
      Future<Response> Function() repositoryConnect,
      T Function(dynamic) repositoryParse,
      ) async {
    try {
      final response = await repositoryConnect();
      switch (response.statusCode) {
        case 200:
          try {
            return right(repositoryParse(response.data));
          } catch (e) {
            return left(DataParseError(Exception(e.toString())));
          }
        case 401:
          return left(DataHttpError(HttpException('Unauthorized')));
        case 500:
          return left(DataHttpError(HttpException('Internal Server Error')));
        default:
          return left(DataHttpError(HttpException('Unknown Error')));
      }
    } on DioException catch (e) {
      if (!await _isConnected()) {
        return left(DataNetworkError(
            NetworkException.noInternetConnection, e.response));
      }

      switch (e.type) {
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
          return left(
              DataNetworkError(NetworkException.timeOutError, e.response));
        default:
          return left(DataNetworkError(NetworkException.unknown, e.response));
      }
    }
  }

  static Future<Either<ErrorState, T>> callSupabase<T>(
      Future<dynamic> Function() repositoryConnect,
      T Function(dynamic) repositoryParse,
      ) async {
    try {
      dynamic response = await repositoryConnect();
      return right(repositoryParse(response));
    } catch (e, s) {
      sl<Talker>().logTyped(SupabaseLogger(e.toString(), s, e));
      if (!await _isConnected()) {
        return left(DataNetworkError(
            NetworkException.noInternetConnection, Response(
            requestOptions: RequestOptions(),
            data: "No internet connection!"
        )));
      } else {
        return left(DataNetworkError(
            NetworkException.unknown, Response(
            requestOptions: RequestOptions(),
            data: "$e\n${s.toString()}"
        )));
      }
    }
  }
}
