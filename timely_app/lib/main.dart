import 'package:flutter/material.dart';
import 'package:timely_app/firebase_options.dart';
import 'package:timely_app/quiz.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Quiz());
}
