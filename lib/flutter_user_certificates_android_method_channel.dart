import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_user_certificates_android_platform_interface.dart';

/// An implementation of [FlutterUserCertificatesAndroidPlatform] that uses method channels.
class MethodChannelFlutterUserCertificatesAndroid
    extends FlutterUserCertificatesAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel('flutter_user_certificates_android');

  @override
  Future<Map<String, Uint8List>?> getUserCertificates() async {
    final certs = await methodChannel.invokeMethod<Map>('getUserCertificates');
    return certs?.cast<String, Uint8List>();
  }
}
