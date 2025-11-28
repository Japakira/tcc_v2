import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/firebase_options.dart';
import 'package:tcc_v2/view/widgets/chechauth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const tituloApp = 'AGeIS';
  static const subtituloApp =
      'Aplicativo de Gestão de Iniciativas no Setor Público';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Alegreya',
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        primaryTextTheme: ThemeData.dark().primaryTextTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(37, 51, 52, 1),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Alegreya',
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        primaryColor: Color.fromRGBO(37, 51, 52, 1),
        scaffoldBackgroundColor: Color.fromRGBO(37, 51, 52, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF7C9A92),
          ),
        ),
      ),
      title: tituloApp,
      home: CheckAuth(),
    );
  }
}
