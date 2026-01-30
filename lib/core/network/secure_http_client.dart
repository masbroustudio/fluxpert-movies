import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

/// Secure HTTP Client with Certificate Pinning
/// This validates the server certificate against a pinned certificate
class SecureHttpClient {
  static const String certificatePath = 'assets/certificates/certificates.pem';
  static const String baseUrl = 'api.themoviedb.org';

  static Future<http.Client> createSecureClient() async {
    try {
      // Load certificate from assets
      final certificateData = await rootBundle.load(certificatePath);
      final bytes = certificateData.buffer.asUint8List();

      if (kDebugMode) {
        debugPrint('🔒 Loading pinned certificate (${bytes.length} bytes)');
      }

      // Create security context with ONLY the pinned certificate
      // withTrustedRoots: false means we don't trust OS certificate store
      final securityContext = SecurityContext(withTrustedRoots: false);
      securityContext.setTrustedCertificatesBytes(bytes);

      // Create HTTP client with pinned certificate
      final httpClient = HttpClient(context: securityContext);
      
      // CRITICAL: badCertificateCallback should return FALSE
      // When it returns false, the SecurityContext's pinned cert is used for validation
      // Returning true would accept ANY certificate (security hole!)
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
        if (kDebugMode) {
          debugPrint('🔒 Validating certificate for $host:$port');
          debugPrint('   Subject: ${cert.subject}');
          debugPrint('   Issuer: ${cert.issuer}');
        }
        
        // Always return FALSE - let SecurityContext do the validation
        // This rejects any certificate that doesn't match our pinned cert
        return false;
      };

      if (kDebugMode) {
        debugPrint('✅ Secure HTTP client created with SSL pinning');
      }

      return IOClient(httpClient);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('❌ SSL Pinning failed: $e');
        debugPrint('   This happens when:');
        debugPrint('   - Certificate file is missing or invalid');
        debugPrint('   - Certificate format is wrong (must be PEM)');
        debugPrint('   - Certificate has been tampered with');
      }
      // DO NOT fallback to regular client - this defeats SSL pinning!
      rethrow;
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
        debugPrint('SSL Pinning check failed: $e');
      }
      return false;
    }
  }
}
