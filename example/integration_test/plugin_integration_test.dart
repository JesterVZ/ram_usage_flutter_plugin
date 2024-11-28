// This is a basic Flutter integration test.
//
// Since integration tests run in a full Flutter application, they can interact
// with the host side of a plugin implementation, unlike Dart unit tests.
//
// For more information about Flutter integration tests, please see
// https://flutter.dev/to/integration-testing


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:ram_usage_plugin/ram_usage_plugin.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Stream emits RAM usage data', (WidgetTester tester) async {
    // Подписываемся на поток
    final stream = RamUsagePlugin.ramUsageStream;

    // Устанавливаем тайм-аут, чтобы поток завершился после 10 секунд
    final results = await stream.take(5).toList();

    // Проверяем, что поток выдает данные
    expect(results, isNotEmpty);

    // Проверяем, что данные находятся в пределах корректного диапазона (0-100%)
    for (final usage in results) {
      expect(usage, greaterThanOrEqualTo(0.0));
      expect(usage, lessThanOrEqualTo(100.0));
    }
  });
}