import 'package:flutter_dotenv/flutter_dotenv.dart';

String? getFullImageUrl(String? url, {int? version}) {
  if (url == null || url.isEmpty || url.toLowerCase().contains('default')) {
    return null;
  }

  if (url.startsWith('http')) {
    return version != null ? _appendVersion(url, version) : url;
  }

  final bucketUrl = dotenv.env['R2_PUBLIC_URL'] ?? '';
  if (bucketUrl.isEmpty) {
    return url;
  }

  String cleanUrl = url;
  if (cleanUrl.startsWith('/')) {
    cleanUrl = cleanUrl.substring(1);
  }

  cleanUrl = cleanUrl.replaceFirst(RegExp(r'^public/uvoluntapp-bucket/'), '');
  cleanUrl = cleanUrl.replaceFirst(RegExp(r'^public/default/'), '');

  final baseUrl = bucketUrl.endsWith('/')
      ? bucketUrl.substring(0, bucketUrl.length - 1)
      : bucketUrl;

  final finalUrl = '$baseUrl/$cleanUrl';
  return version != null ? _appendVersion(finalUrl, version) : finalUrl;
}

String _appendVersion(String url, int version) {
  if (url.contains('?')) {
    return '$url&v=$version';
  }
  return '$url?v=$version';
}
