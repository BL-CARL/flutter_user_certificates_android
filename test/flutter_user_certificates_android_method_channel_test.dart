import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_certificates_android/flutter_user_certificates_android_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutterUserCertificatesAndroid platform =
      MethodChannelFlutterUserCertificatesAndroid();
  const MethodChannel channel =
      MethodChannel('flutter_user_certificates_android');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return <String, Uint8List>{};
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getUserCertificates', () async {
    expect(await platform.getUserCertificates(), {});
  });
}
