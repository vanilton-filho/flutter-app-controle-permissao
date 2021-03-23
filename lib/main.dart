import 'package:controle_permissao_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(
    ControlePermissaoApp(),
  );
}

class ControlePermissaoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.green, // navigation bar color
    //   statusBarColor: Colors.green, // status bar color
    // ));
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Controle de Permissão',
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('pt', 'BR'), const Locale('en', 'US')],
    );
  }
}
