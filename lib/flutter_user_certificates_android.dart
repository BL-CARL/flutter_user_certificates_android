import 'dart:convert';
import 'dart:typed_data';

import 'flutter_user_certificates_android_platform_interface.dart';

class FlutterUserCertificatesAndroid {
  Future<Map<String, DERCertificate>?> getUserCertificates() {
    return FlutterUserCertificatesAndroidPlatform.instance
        .getUserCertificates();
  }
}

typedef DERCertificate = Uint8List;

typedef PEMCertificate = String;

extension DERExt on DERCertificate {
  PEMCertificate toPEM() {
    final bin = base64Encode(this);
    return '''-----BEGIN CERTIFICATE-----
$bin
-----END CERTIFICATE-----''';
  }
}

extension PEMExt on PEMCertificate {
  DERCertificate toDER() {
    final bin = replaceAll('-----BEGIN CERTIFICATE-----', '')
        .replaceAll('-----END CERTIFICATE-----', '')
        .replaceAll('\n', '');
    return base64Decode(bin);
  }

  List<int> get bytes => codeUnits;
}
