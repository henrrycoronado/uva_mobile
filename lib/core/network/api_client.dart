import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiClientProvider = Provider<Dio>((ref) {
  final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:5001/api/v1';

  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      return handler.next(options);
    },
    onError: (error, handler) {
      return handler.next(error);
    },
  ));

  return dio;
});
