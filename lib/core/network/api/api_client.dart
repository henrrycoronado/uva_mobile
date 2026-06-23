import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;

import '../../local_storage/secure/i_secure_storage.dart';
import '../models/api_exceptions.dart';
import 'i_api_client.dart';

class ApiClient implements IApiClient {
  final String _baseUrl;
  final http.Client _client;
  final ISecureStorage secureStorage;

  ApiClient({http.Client? client, required this.secureStorage})
    : _baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000/api/v1',
      _client = client ?? http.Client();

  @override
  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: await _buildHeaders(headers),
    );
    return _handleResponse(response);
  }

  @override
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: await _buildHeaders(headers),
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  @override
  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await _client.put(
      Uri.parse('$_baseUrl$endpoint'),
      headers: await _buildHeaders(headers),
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  @override
  Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final response = await _client.patch(
      Uri.parse('$_baseUrl$endpoint'),
      headers: await _buildHeaders(headers),
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  @override
  Future<void> delete(String endpoint, {Map<String, String>? headers}) async {
    final response = await _client.delete(
      Uri.parse('$_baseUrl$endpoint'),
      headers: await _buildHeaders(headers),
    );
    _handleResponse(response, isDelete: true);
  }

  @override
  Future<dynamic> patchMultipart(
    String endpoint, {
    required String filePath,
    required String fileFieldName,
    Map<String, String>? headers,
  }) async {
    final request = http.MultipartRequest(
      'PATCH',
      Uri.parse('$_baseUrl$endpoint'),
    );

    // Apply custom headers and auth
    final baseHeaders = await _buildHeaders(headers);
    // Remove content-type to let multipart handle it
    baseHeaders.remove('Content-Type');
    request.headers.addAll(baseHeaders);

    final ext = p.extension(filePath).toLowerCase();
    MediaType? contentType;
    if (ext == '.jpg' || ext == '.jpeg') {
      contentType = MediaType('image', 'jpeg');
    } else if (ext == '.png') {
      contentType = MediaType('image', 'png');
    }

    // Attach file
    request.files.add(
      await http.MultipartFile.fromPath(
        fileFieldName,
        filePath,
        contentType: contentType,
      ),
    );

    final streamedResponse = await _client.send(request);
    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }

  Future<Map<String, String>> _buildHeaders(
    Map<String, String>? customHeaders,
  ) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final token = await secureStorage.getToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    return headers;
  }

  dynamic _handleResponse(http.Response response, {bool isDelete = false}) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (isDelete || response.body.isEmpty) return <String, dynamic>{};
      try {
        return jsonDecode(response.body);
      } catch (_) {
        return <String, dynamic>{};
      }
    } else {
      ProblemDetails? problem;
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          problem = ProblemDetails.fromJson(decoded);
        }
      } catch (_) {
        throw ApiException(
          "invalidResponse",
          statusCode: response.statusCode,
          problemDetails: problem,
        );
      }

      final message = problem?.detail ?? problem?.title ?? 'httpError';

      switch (response.statusCode) {
        case 400:
          throw BadRequestException(message, problemDetails: problem);
        case 401:
          throw UnauthorizedException(message, problemDetails: problem);
        case 403:
          throw ForbiddenException(message, problemDetails: problem);
        case 404:
          throw NotFoundException(message, problemDetails: problem);
        default:
          if (response.statusCode >= 500) {
            throw ServerException(message, problemDetails: problem);
          }
          throw ApiException(
            message,
            statusCode: response.statusCode,
            problemDetails: problem,
          );
      }
    }
  }
}
