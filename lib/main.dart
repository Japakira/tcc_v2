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
    var media = MediaQueryData();
    return MediaQuery(
      data: media,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Alegreya',
          // Ensure all text styles default to white
          textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          primaryTextTheme: ThemeData.dark().primaryTextTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
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
          iconTheme: IconThemeData(color: Colors.white),
          // Buttons should use white text by default
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF7C9A92),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
          ),
          buttonTheme: ButtonThemeData(buttonColor: Color(0xFF7C9A92)),
        ),
        title: tituloApp,
        home: CheckAuth(),
      ),
    );
  }
}
