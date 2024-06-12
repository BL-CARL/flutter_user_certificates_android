import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_certificates_android/flutter_user_certificates_android.dart';
import 'package:flutter_user_certificates_android/flutter_user_certificates_android_platform_interface.dart';
import 'package:flutter_user_certificates_android/flutter_user_certificates_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUserCertificatesAndroidPlatform
    with MockPlatformInterfaceMixin
    implements FlutterUserCertificatesAndroidPlatform {
  @override
  Future<Map<String, Uint8List>?> getUserCertificates() => Future.value({});
}

void main() {
  final FlutterUserCertificatesAndroidPlatform initialPlatform =
      FlutterUserCertificatesAndroidPlatform.instance;

  test('$MethodChannelFlutterUserCertificatesAndroid is the default instance',
      () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelFlutterUserCertificatesAndroid>());
  });

  test('getUserCertificates', () async {
    FlutterUserCertificatesAndroid flutterUserCertificatesAndroidPlugin =
        FlutterUserCertificatesAndroid();
    MockFlutterUserCertificatesAndroidPlatform fakePlatform =
        MockFlutterUserCertificatesAndroidPlatform();
    FlutterUserCertificatesAndroidPlatform.instance = fakePlatform;

    expect(
        await flutterUserCertificatesAndroidPlugin.getUserCertificates(), {});
  });

  test('to DER/PEM', () {
    final DERCertificate der1 = Uint8List.fromList([1, 2, 3, 4, 5]);
    final PEMCertificate pem1 = der1.toPEM();
    expect(pem1.toDER(), der1);

    const PEMCertificate pem2 = '''-----BEGIN CERTIFICATE-----
ABCD1234
-----END CERTIFICATE-----''';
    final DERCertificate der2 = pem2.toDER();
    expect(der2.toPEM(), pem2);
  });
}
