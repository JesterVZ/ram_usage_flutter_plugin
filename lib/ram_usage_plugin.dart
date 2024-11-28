
import 'package:flutter/services.dart';


class RamUsagePlugin {
  static const EventChannel _eventChannel = EventChannel('ram_usage_plugin');

  static Stream<double> get ramUsageStream {
    return _eventChannel
        .receiveBroadcastStream()
        .map((event) => event as double);
  }
}
