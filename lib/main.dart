import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:link_refurb/app_blocs.dart';
import 'package:link_refurb/app_repositories.dart';
import 'package:link_refurb/ui/auth/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage storage = FlutterSecureStorage();

  var appConfig = AppRespositories(
    appBlocs: AppBlocs(
      app: MyApp(),
      storage: storage,
    ),
    storage: storage,
  );
  runApp(appConfig);
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Links App',
      home: SplashScreen(),
    );
  }
}
