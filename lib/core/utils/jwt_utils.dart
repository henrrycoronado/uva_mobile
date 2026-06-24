import 'dart:convert';

class JwtUtils {
  static Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload');
    }

    return payloadMap;
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }

  static List<String> getRolesFromToken(String token) {
    try {
      final payload = parseJwt(token);

      // Standard .NET claim for roles
      const roleClaim =
          'http://schemas.microsoft.com/ws/2008/06/identity/claims/role';

      var roles = payload[roleClaim];
      roles ??= payload['roles'] ?? payload['role'];

      if (roles is List) {
        return roles.map((e) => e.toString()).toList();
      } else if (roles is String) {
        return [roles];
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  static String? getUserIdFromToken(String token) {
    try {
      final payload = parseJwt(token);
      return payload['sub']?.toString();
    } catch (e) {
      return null;
    }
  }
}
