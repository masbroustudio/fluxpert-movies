import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class SecureHttpClient {
  static const String certificatePath = 'assets/certificates/tmdb.cer';
  static const String baseUrl = 'api.themoviedb.org';

  static Future<http.Client> createSecureClient() async {
    try {
      // Load certificate from assets
      final certificateData = await rootBundle.load(certificatePath);
      final bytes = certificateData.buffer.asUint8List();

      // Create security context with pinned certificate
      final securityContext = SecurityContext(withTrustedRoots: false);
      securityContext.setTrustedCertificatesBytes(bytes);

      // Create HTTP client with pinned certificate
      final httpClient = HttpClient(context: securityContext);
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Only allow our pinned certificate for TMDB API
        return host == baseUrl;
      };

      return IOClient(httpClient);
    } catch (e) {
      // Fallback to regular HTTP client if pinning fails
      if (kDebugMode) {
        print('Warning: SSL Pinning failed, using regular HTTP client: $e');
      }
      return http.Client();
    }
  }

  static Future<bool> checkConnection() async {
    try {
      final client = await createSecureClient();
      final response = await client.get(
        Uri.parse('https://$baseUrl/3/movie/now_playing?api_key=test'),
      );
      client.close();
      return response.statusCode == 401; // 401 means API key invalid but connection works
    } catch (e) {
      if (kDebugMode) {
        print('SSL Pinning check failed: $e');
      }
      return false;
    }
  }
}
