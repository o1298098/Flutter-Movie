import 'package:flutter/material.dart';

import 'app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Future.delayed(Duration(milliseconds: 300));
  runApp(await createApp());
}
