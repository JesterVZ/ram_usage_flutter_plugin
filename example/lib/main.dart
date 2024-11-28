import 'package:flutter/material.dart';
import 'package:ram_usage_plugin/ram_usage_plugin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double? ramUsage;

  @override
  void initState() {
    super.initState();
    RamUsagePlugin.ramUsageStream.listen((usage) {
      setState(() {
        ramUsage = usage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('RAM Usage Stream Example')),
        body: Center(
          child: ramUsage == null
              ? CircularProgressIndicator()
              : Text('RAM Usage: ${ramUsage!.toStringAsFixed(2)}%'),
        ),
      ),
    );
  }
}
