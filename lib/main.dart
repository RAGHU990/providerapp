import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/utils/configs.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_screen.dart';
import 'controllers/auth_controller.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: Config.supbaseURL,
    anonKey: Config.anonKey);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthController(Supabase.instance.client),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Supabase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
    );
  }
}