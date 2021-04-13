import 'package:controle_permissao_app/pages/ativacao_page.dart';
import 'package:controle_permissao_app/pages/create_usuario_page.dart';
import 'package:controle_permissao_app/pages/usuarios_ativos_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    UsuariosAtivosPage(),
    CreateUsuarioPage(),
    AtivacaoPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0 || _currentIndex == 2
          ? AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Controle de Permissão",
                style: GoogleFonts.sourceSansPro(
                    fontSize: 23, height: 3.0, fontWeight: FontWeight.bold),
              ),
            )
          : null,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Configurações')
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
