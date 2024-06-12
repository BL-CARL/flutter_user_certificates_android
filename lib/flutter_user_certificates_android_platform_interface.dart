import 'package:flutter_user_certificates_android/flutter_user_certificates_android.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_user_certificates_android_method_channel.dart';

abstract class FlutterUserCertificatesAndroidPlatform
    extends PlatformInterface {
  /// Constructs a FlutterUserCertificatesAndroidPlatform.
  FlutterUserCertificatesAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUserCertificatesAndroidPlatform _instance =
      MethodChannelFlutterUserCertificatesAndroid();

  /// The default instance of [FlutterUserCertificatesAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUserCertificatesAndroid].
  static FlutterUserCertificatesAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUserCertificatesAndroidPlatform] when
  /// they register themselves.
  static set instance(FlutterUserCertificatesAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<String, DERCertificate>?> getUserCertificates() {
    throw UnimplementedError('getUserCertificates() has not been implemented.');
  }
}
