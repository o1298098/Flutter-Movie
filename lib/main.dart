import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  runApp(await createApp());
}
