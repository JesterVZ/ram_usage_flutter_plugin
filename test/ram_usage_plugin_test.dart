import 'package:flutter_test/flutter_test.dart';
import 'package:ram_usage_plugin/ram_usage_plugin.dart';
import 'package:ram_usage_plugin/ram_usage_plugin_platform_interface.dart';
import 'package:ram_usage_plugin/ram_usage_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRamUsagePluginPlatform
    with MockPlatformInterfaceMixin
    implements RamUsagePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RamUsagePluginPlatform initialPlatform = RamUsagePluginPlatform.instance;

  test('$MethodChannelRamUsagePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRamUsagePlugin>());
  });

  test('getPlatformVersion', () async {
    RamUsagePlugin ramUsagePlugin = RamUsagePlugin();
    MockRamUsagePluginPlatform fakePlatform = MockRamUsagePluginPlatform();
    RamUsagePluginPlatform.instance = fakePlatform;

    expect(await ramUsagePlugin.getPlatformVersion(), '42');
  });
}
