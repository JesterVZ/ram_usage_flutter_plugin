import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ram_usage_plugin_platform_interface.dart';

/// An implementation of [RamUsagePluginPlatform] that uses method channels.
class MethodChannelRamUsagePlugin extends RamUsagePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ram_usage_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
