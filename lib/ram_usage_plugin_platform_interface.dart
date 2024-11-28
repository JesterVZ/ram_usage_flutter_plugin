import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ram_usage_plugin_method_channel.dart';

abstract class RamUsagePluginPlatform extends PlatformInterface {
  /// Constructs a RamUsagePluginPlatform.
  RamUsagePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static RamUsagePluginPlatform _instance = MethodChannelRamUsagePlugin();

  /// The default instance of [RamUsagePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelRamUsagePlugin].
  static RamUsagePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RamUsagePluginPlatform] when
  /// they register themselves.
  static set instance(RamUsagePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
