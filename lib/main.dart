import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social/shared/components/uid.dart';
import 'package:social/shared/services/local/cache_helper.dart';

import 'theme.dart';
import '/screens/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await CacheHelper.init();

  runApp(const SocialApp());
}

class SocialApp extends StatelessWidget {
  const SocialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SocialTheme.light(),
      home: const LoginScreen(),
    );
  }
}
