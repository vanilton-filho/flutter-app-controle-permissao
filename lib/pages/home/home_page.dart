import 'package:controle_permissao_app/model/usuario_ativo.dart';
import 'package:controle_permissao_app/pages/widgets/custom_card_widget.dart';
import 'package:controle_permissao_app/service/usuario_ativo_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UsuarioAtivoService usuarioAtivoService = new UsuarioAtivoService();
  late final Future<List<UsuarioAtivo>> futureUsuarioAtivo;

  @override
  void initState() {
    super.initState();
    // Agora nossa Future de List<UsuarioAtivo> está no escopo de gerenciamento de estados desse widget
    futureUsuarioAtivo = usuarioAtivoService.fetchUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.verified_user),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/active'))
        ],
        centerTitle: true,
        title: Text("Controle de Permissão",
            style: GoogleFonts.roboto(fontSize: 21)),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshUsuarios,
        child: FutureBuilder(
          future: futureUsuarioAtivo,
          builder: (context, AsyncSnapshot<List<UsuarioAtivo>> snapshot) {
            if (snapshot.hasData) {
              List<UsuarioAtivo> usuariosAtivos = snapshot.data!;
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: usuariosAtivos.length,
                  itemBuilder: (context, index) {
                    final usuarioAtivo = usuariosAtivos[index];
                    return CustomCardWidget(
                      usuario: usuarioAtivo,
                    );
                  });
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 68.0,
                  ),
                  Text(
                    '${snapshot.error}',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Ops... algo de errado aconteceu, tente novamente em alguns instantes.',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Cadastrar novo usuário',
        onPressed: () => _navigateToCreateUsuario(context),
      ),
    );
  }

  _navigateToCreateUsuario(BuildContext context) {
    return Navigator.pushReplacementNamed(context, '/create');
  }

  Future<void> _refreshUsuarios() async {
    final UsuarioAtivoService usuarioService = UsuarioAtivoService();

    setState(() {
      usuarioService.fetchUsuarios();
    });
  }
}
