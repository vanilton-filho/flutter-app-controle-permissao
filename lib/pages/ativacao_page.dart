import 'package:controle_permissao_app/model/usuario.dart';
import 'package:controle_permissao_app/service/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AtivacaoPage extends StatefulWidget {
  @override
  _AtivacaoPageState createState() => _AtivacaoPageState();
}

class _AtivacaoPageState extends State<AtivacaoPage> {
  UsuarioService usuarioService = new UsuarioService();
  late final Future<List<Usuario>> futureUsuarioAtivo;

  @override
  void initState() {
    super.initState();
    // Agora nossa Future de List<Usuario> está no escopo de gerenciamento de estados desse widget
    futureUsuarioAtivo = usuarioService.fetchUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black,
                size: 42.0,
              ),
              onPressed: () => Navigator.popAndPushNamed(context, '/'),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshUsuarios,
        child: FutureBuilder(
          future: futureUsuarioAtivo,
          builder: (context, AsyncSnapshot<List<Usuario>> snapshot) {
            if (snapshot.hasData) {
              List<Usuario> usuariosAtivos = snapshot.data!;
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: usuariosAtivos.length,
                  itemBuilder: (context, index) {
                    final usuarioAtivo = usuariosAtivos[index];
                    return SwitchListTile(
                        title: Text(
                          '@${usuarioAtivo.login}',
                          style: GoogleFonts.sourceSansPro(fontSize: 21.0),
                        ),
                        value: usuarioAtivo.status!,
                        onChanged: (value) {
                          if (value)
                            usuarioService.ativar(usuarioAtivo.id!);
                          else
                            usuarioService.desativar(usuarioAtivo.id!);

                          setState(() {
                            usuarioAtivo.status = value;
                          });
                        });
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
    );
  }

  Future<void> _refreshUsuarios() async {
    final UsuarioService usuarioService = UsuarioService();

    setState(() {
      usuarioService.fetchUsuarios();
    });
  }
}
