import 'package:controle_permissao_app/model/usuario_ativo.dart';
import 'package:controle_permissao_app/pages/widgets/custom_tile_widget.dart';
import 'package:controle_permissao_app/service/usuario_ativo_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsuariosAtivosPage extends StatefulWidget {
  @override
  _UsuariosAtivosPageState createState() => _UsuariosAtivosPageState();
}

class _UsuariosAtivosPageState extends State<UsuariosAtivosPage> {
  UsuarioAtivoService usuarioAtivoService = new UsuarioAtivoService();
  Future<List<UsuarioAtivo>>? futureUsuarioAtivo;

  @override
  void initState() {
    super.initState();
    futureUsuarioAtivo = usuarioAtivoService.fetchUsuarios();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Container(
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
          future: futureUsuarioAtivo,
          builder: (context, AsyncSnapshot<List<UsuarioAtivo>> snapshot) {
            if (snapshot.hasData) {
              List<UsuarioAtivo> usuariosAtivos = snapshot.data!;
              return RefreshIndicator(
                onRefresh: _refreshUsuarios,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: usuariosAtivos.length,
                    itemBuilder: (context, index) {
                      final usuarioAtivo = usuariosAtivos[index];
                      return CustomTileWidget(
                        usuario: usuarioAtivo,
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
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
                ),
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
    setState(() {
      futureUsuarioAtivo = usuarioAtivoService.fetchUsuarios();
    });
  }
}
