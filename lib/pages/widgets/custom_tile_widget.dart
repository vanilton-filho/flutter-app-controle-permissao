import 'package:controle_permissao_app/model/usuario.dart';
import 'package:controle_permissao_app/model/usuario_ativo.dart';
import 'package:controle_permissao_app/pages/update_usuario_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomTileWidget extends StatefulWidget {
  final UsuarioAtivo? usuario;

  CustomTileWidget({this.usuario});

  @override
  _CustomTileWidgetState createState() => _CustomTileWidgetState();
}

class _CustomTileWidgetState extends State<CustomTileWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildUsuarioAtivoTile(widget.usuario!);
  }

  _buildUsuarioAtivoTile(UsuarioAtivo usuarioAtivo) {
    final TextStyle customStyle = GoogleFonts.sourceSansPro(fontSize: 18);
    return Container(
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildInfoRow(
                usuarioAtivo.nome!,
                customStyle,
                Icons.person_outlined,
              ),
              _buildInfoRow(
                usuarioAtivo.login!,
                customStyle,
                Icons.alternate_email_outlined,
              ),
              _buildInfoRow(
                usuarioAtivo.email!,
                customStyle,
                Icons.email_outlined,
              ),
              _buildInfoRow(
                DateFormat('dd/MM/yyyy').format(usuarioAtivo.dataNascimento!),
                customStyle,
                Icons.cake_outlined,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () => _navigateToUpdatePage(),
                        child: Text(
                          'EDITAR',
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          // shape: MaterialStateProperty.all<
                          //     RoundedRectangleBorder>(
                          //   RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(18.0),
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.settings,
                ),
                title: Text(
                  'Recursos (${usuarioAtivo.recursos!.length})',
                  style: GoogleFonts.sourceSansPro(),
                ),
                children: [
                  for (var recurso in usuarioAtivo.recursos!)
                    ListTile(
                      dense: true,
                      title: Text(
                        recurso.nome!,
                      ),
                    ),
                ],
              ),
              Divider(
                thickness: 1,
                height: 21.0,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildInfoRow(String info, TextStyle style, IconData icon) {
    final String tooltip = info;
    if (info.length > 30) {
      info = info.substring(0, 30);
      info = info + " ...";
    }

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tooltip(
              message: tooltip,
              child: Text(
                info,
                style: style,
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  /// Criamos um usuário para pegar os dados do usuário no contexto
  /// e enviados junto com o roteamento
  _navigateToUpdatePage() {
    Usuario usuario = Usuario();
    usuario.id = this.widget.usuario!.id;
    usuario.nome = this.widget.usuario!.nome;
    usuario.login = this.widget.usuario!.login;
    usuario.email = this.widget.usuario!.email;
    usuario.dataNascimento = this.widget.usuario!.dataNascimento!;
    this.widget.usuario!.recursos!.forEach((recurso) {
      usuario.recursos!.add(recurso.id!);
    });

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateUsuarioPage(usuario: usuario)));
  }
}
