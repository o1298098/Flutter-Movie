import 'package:flutter/material.dart';

import 'app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(await createApp());
}
