import 'package:controle_permissao_app/pages/ativacao_page.dart';
import 'package:controle_permissao_app/pages/create_usuario_page.dart';
import 'package:controle_permissao_app/pages/home_page.dart';
import 'package:controle_permissao_app/pages/update_usuario_page.dart';
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
    return MaterialApp(
      title: 'Controle de Permissão',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/create': (context) => CreateUsuarioPage(),
        '/update': (context) => UpdateUsuarioPage(),
        '/active': (context) => AtivacaoPage(),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('pt', 'BR'), const Locale('en', 'US')],
    );
  }
}
