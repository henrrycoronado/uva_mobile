abstract class IApiClient {
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
  });
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
  Future<Map<String, dynamic>> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
  Future<void> delete(String endpoint, {Map<String, String>? headers});
}
