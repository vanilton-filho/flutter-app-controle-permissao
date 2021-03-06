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
  late final Future<List<Usuario>> futureUsuarios;

  @override
  void initState() {
    super.initState();
    futureUsuarios = usuarioService.fetchUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 42.0),
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 42.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(27.0),
                topRight: Radius.circular(27.0),
              )),
          child: FutureBuilder(
            future: futureUsuarios,
            builder: (context, AsyncSnapshot<List<Usuario>> snapshot) {
              if (snapshot.hasData) {
                List<Usuario> usuarios = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: _refreshUsuarios,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: usuarios.length,
                      itemBuilder: (context, index) {
                        final usuarioAtivo = usuarios[index];
                        return SwitchListTile(
                            title: Text(
                              '@${usuarioAtivo.login}',
                              style: GoogleFonts.sourceSansPro(fontSize: 21.0),
                            ),
                            value: usuarioAtivo.status!,
                            onChanged: (value) =>
                                _ativaOuDesativa(value, usuarioAtivo));
                      }),
                );
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
      ),
    );
  }

  Future<void> _refreshUsuarios() async {
    final UsuarioService usuarioService = UsuarioService();

    setState(() {
      usuarioService.fetchUsuarios();
    });
  }

  _ativaOuDesativa(bool value, Usuario usuario) async {
    bool isOk;
    if (value)
      isOk = await usuarioService.ativar(usuario.id!);
    else
      isOk = await usuarioService.desativar(usuario.id!);

    if (isOk) {
      setState(() {
        usuario.status = value;
      });
    }
  }
}
