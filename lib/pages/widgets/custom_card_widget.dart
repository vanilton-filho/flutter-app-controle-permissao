import 'dart:math' as math;

import 'package:controle_permissao_app/model/usuario_ativo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCardWidget extends StatelessWidget {
  final UsuarioAtivo? usuario;

  CustomCardWidget({this.usuario});

  @override
  Widget build(BuildContext context) {
    return _buildUsuarioAtivoTile(usuario!);
  }

  _buildUsuarioAtivoTile(UsuarioAtivo usuarioAtivo) {
    final TextStyle customStyle = GoogleFonts.sourceSansPro(fontSize: 18);
    return Container(
      child: Card(
        shape: Border(
          top: BorderSide(color: Colors.blueGrey, width: 10),
        ),
        child: Padding(
          padding: EdgeInsets.all(3.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _buildInfoRow(
                        usuarioAtivo.nome!,
                        customStyle,
                        Icons.person,
                      ),
                      _buildInfoRow(
                        usuarioAtivo.login!,
                        customStyle,
                        Icons.alternate_email,
                      ),
                      _buildInfoRow(
                        usuarioAtivo.email!,
                        customStyle,
                        Icons.email,
                      ),
                      _buildInfoRow(
                        usuarioAtivo.dataNascimento!,
                        customStyle,
                        Icons.cake,
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () => print('ahoy'),
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
                        ],
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
                    ],
                  ),
                ),
              ),
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
        ],
      ),
    );
  }

  _randomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }
}
