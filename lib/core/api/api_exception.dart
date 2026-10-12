import 'package:dio/dio.dart';

/// Een mislukte API-aanroep, vertaald uit Laravels JSON (`message` + `errors`).
///
/// Schermen switchen op het subtype (`switch (e) { ValidationException() => … }`)
/// in plaats van op statuscodes.
sealed class ApiException implements Exception {
  const ApiException({this.statusCode, this.message, this.errors = const {}});

  /// Bouwt het juiste subtype uit een [DioException].
  factory ApiException.fromDio(DioException error) {
    if (error.error case final ApiException inner) return inner;

    final response = error.response;
    if (response == null) {
      return switch (error.type) {
        DioExceptionType.connectionError ||
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout => NetworkException(
          message: error.message,
        ),
        _ => UnknownApiException(message: error.message),
      };
    }

    final status = response.statusCode ?? 0;
    final body = response.data;
    String? message;
    var errors = const <String, List<String>>{};
    if (body is Map) {
      final rawMessage = body['message'];
      if (rawMessage is String && rawMessage.isNotEmpty) message = rawMessage;
      errors = _parseErrors(body['errors']);
    }

    return switch (status) {
      401 => UnauthorizedException(message: message),
      403 => ForbiddenException(message: message),
      404 => NotFoundException(message: message),
      409 => ConflictException(message: message, errors: errors),
      422 => ValidationException(message: message, errors: errors),
      429 => ThrottledException(message: message, errors: errors),
      >= 500 => ServerException(statusCode: status, message: message),
      _ => UnknownApiException(
        statusCode: status,
        message: message,
        errors: errors,
      ),
    };
  }

  /// HTTP-status, of `null` als er geen antwoord kwam.
  final int? statusCode;

  /// Laravels `message` (Nederlands), indien aanwezig.
  final String? message;

  /// Laravels `errors`: veld → meldingen.
  final Map<String, List<String>> errors;

  /// De eerste melding voor [field], of `null`.
  String? fieldError(String field) {
    final messages = errors[field];
    return messages == null || messages.isEmpty ? null : messages.first;
  }

  static Map<String, List<String>> _parseErrors(Object? raw) {
    if (raw is! Map) return const {};
    return {
      for (final entry in raw.entries)
        '${entry.key}': switch (entry.value) {
          final List<Object?> list => [for (final m in list) '$m'],
          final Object value => ['$value'],
          null => const <String>[],
        },
    };
  }

  @override
  String toString() => '$runtimeType($statusCode): ${message ?? ''}';
}

/// Geen antwoord: offline, time-out, server onbereikbaar.
final class NetworkException extends ApiException {
  const NetworkException({super.message});
}

/// 401 — geen of ongeldig token. De app logt dan uit.
final class UnauthorizedException extends ApiException {
  const UnauthorizedException({super.message}) : super(statusCode: 401);
}

/// 403 — ingelogd, maar geen toegang.
final class ForbiddenException extends ApiException {
  const ForbiddenException({super.message}) : super(statusCode: 403);
}

/// 404 — bestaat niet (of niet binnen dit team).
final class NotFoundException extends ApiException {
  const NotFoundException({super.message}) : super(statusCode: 404);
}

/// 409 — conflict met de huidige stand.
final class ConflictException extends ApiException {
  const ConflictException({super.message, super.errors})
    : super(statusCode: 409);
}

/// 422 — validatiefout, met [errors] per veld.
final class ValidationException extends ApiException {
  const ValidationException({super.message, super.errors})
    : super(statusCode: 422);
}

/// 429 — te veel pogingen (bij de inlogcode met `errors.code`).
final class ThrottledException extends ApiException {
  const ThrottledException({super.message, super.errors})
    : super(statusCode: 429);
}

/// 5xx.
final class ServerException extends ApiException {
  const ServerException({required int super.statusCode, super.message});
}

/// Al het andere.
final class UnknownApiException extends ApiException {
  const UnknownApiException({super.statusCode, super.message, super.errors});
}
