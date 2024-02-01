import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'QR_Scan and Bar_Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? scanResult;
  bool checkLineUrl = false;
  bool checkFacebookUrl = false;
  bool checkYoutubeUrl = false;
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.lightGreenAccent,
    backgroundColor: Colors.lightGreen[800],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );
  final ButtonStyle raisedButtonStyle1 = ElevatedButton.styleFrom(
    foregroundColor: Colors.blueAccent,
    backgroundColor: Colors.lightBlue[800],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );
  final ButtonStyle raisedButtonStyle2 = ElevatedButton.styleFrom(
    foregroundColor: Colors.redAccent,
    backgroundColor: Colors.red[800],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: 300,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Result Scan",
                      style: TextStyle(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      (scanResult ?? "No data anymore"),
                      style: const TextStyle(fontSize: 25),
                    ),
                    const Spacer(),
                    checkLineUrl
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  await launchUrlString(scanResult!);
                                },
                                style: raisedButtonStyle,
                                child: const Text(
                                  "Follow me by Line",
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        : Container(),
                    const Spacer(),
                    checkFacebookUrl
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await launchUrlString(scanResult!);
                              },
                              style: raisedButtonStyle1,
                              child: const Text(
                                "Follow me by Facebook",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : Container(),
                    const Spacer(),
                    checkYoutubeUrl
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await launchUrlString(scanResult!);
                              },
                              style: raisedButtonStyle2,
                              child: const Text(
                                "Follow me by Youtube",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startScan,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  startScan() async {
    String? cameraScanResult = await scanner.scan();
    setState(() {
      scanResult = cameraScanResult!;
    });
    if (scanResult!.contains("line.me")) {
      checkLineUrl = true;
    } else if (scanResult!.contains("facebook.com")) {
      checkFacebookUrl = true;
    } else if (scanResult!.contains("youtube.com")) {
      checkYoutubeUrl = true;
    }
  }
}
