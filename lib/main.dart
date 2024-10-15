import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:no_screenshot/screenshot_snapshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _noScreenshot = NoScreenshot.instance;

  final bool _isListeningToScreenshotSnapshot = false;

  //unused
  ScreenshotSnapshot _latestValue = ScreenshotSnapshot(
    isScreenshotProtectionOn: false,
    wasScreenshotTaken: false,
    screenshotPath: '',
  );

  @override
  void initState() {
    super.initState();
    //use for screenshotOff
    _noScreenshot.screenshotOff();

    //unused
    _noScreenshot.screenshotStream.listen((value) {
      setState(() {
        _latestValue = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> dummyItems =
        List.generate(20, (index) => "Item $index: This is some dummy text");

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('No Screenshot'),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                      "Screenshot Streaming is ${_isListeningToScreenshotSnapshot ? 'ON' : 'OFF'}\n\nIsScreenshotProtectionOn: ${_latestValue.isScreenshotProtectionOn}\nwasScreenshotTaken: ${_latestValue.wasScreenshotTaken}\nScreenshot Path: ${_latestValue.screenshotPath}"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: dummyItems.length, // Number of items in the list
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            dummyItems[index],
                            // Display each item from the list
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
