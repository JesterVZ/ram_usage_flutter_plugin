import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ram_usage_plugin/ram_usage_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelRamUsagePlugin platform = MethodChannelRamUsagePlugin();
  const MethodChannel channel = MethodChannel('ram_usage_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
