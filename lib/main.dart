import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:products_app/conts/global_colors.dart';
import 'package:products_app/screens/home_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Rest Api',
    theme: ThemeData(
      scaffoldBackgroundColor: lightScaffoldColor,
      primaryColor: lightCardColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: lightIconsColor,
        ),
        backgroundColor: lightScaffoldColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: lightTextColor, fontSize: 22, fontWeight: FontWeight.bold),
        elevation: 0,
      ),
      iconTheme: IconThemeData(
        color: lightIconsColor,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Colors.blue,

        // selectionHandleColor: Colors.blue,
      ),
      cardColor: lightCardColor,
      brightness: Brightness.light, colorScheme: ThemeData().colorScheme.copyWith(
            secondary: lightIconsColor,
            brightness: Brightness.light,
          ).copyWith(background: lightBackgroundColor),
    ),
    home: HomeScreen(),
  ));
}
