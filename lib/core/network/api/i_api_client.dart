abstract class IApiClient {
  Future<dynamic> get(String endpoint, {Map<String, String>? headers});
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
  Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
  Future<void> delete(String endpoint, {Map<String, String>? headers});
}
