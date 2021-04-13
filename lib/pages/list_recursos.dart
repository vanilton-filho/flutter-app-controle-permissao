import 'package:controle_permissao_app/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListRecursos extends StatefulWidget {
  Usuario? usuario;

  ListRecursos({this.usuario});

  @override
  _ListRecursosState createState() => _ListRecursosState();
}

class _ListRecursosState extends State<ListRecursos> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recursos',
              style: GoogleFonts.roboto(fontSize: 16),
            ),
            Padding(padding: const EdgeInsets.all(3.0)),
            Wrap(
              children: [
                Text(
                  'Se desejar você pode selecionar um ou mais recursos para criar um usuário',
                  style: GoogleFonts.robotoCondensed(fontSize: 14.0),
                )
              ],
            ),
            CheckboxListTile(
                title: const Text('Editar Perfil'),
                value:
                    this.widget.usuario!.recursosOption![Usuario.EditarPerfil],
                onChanged: (bool? val) {
                  setState(() {
                    this.widget.usuario!.recursosOption![Usuario.EditarPerfil] =
                        val!;
                  });
                }),
            CheckboxListTile(
                title: const Text('Visualizar Perfil'),
                value: this
                    .widget
                    .usuario!
                    .recursosOption![Usuario.VisualizarPerfil],
                onChanged: (bool? val) {
                  setState(() {
                    this
                        .widget
                        .usuario!
                        .recursosOption![Usuario.VisualizarPerfil] = val!;
                  });
                }),
            CheckboxListTile(
                title: const Text('Editar Post'),
                value: this.widget.usuario!.recursosOption![Usuario.EditarPost],
                onChanged: (bool? val) {
                  setState(() {
                    this.widget.usuario!.recursosOption![Usuario.EditarPost] =
                        val!;
                  });
                }),
            CheckboxListTile(
                title: const Text('Visualizar Post'),
                value: this
                    .widget
                    .usuario!
                    .recursosOption![Usuario.VisualizarPost],
                onChanged: (bool? val) {
                  setState(() {
                    this
                        .widget
                        .usuario!
                        .recursosOption![Usuario.VisualizarPost] = val!;
                  });
                }),
            CheckboxListTile(
                title: const Text('Excluir Post'),
                value:
                    this.widget.usuario!.recursosOption![Usuario.ExcluirPost],
                onChanged: (bool? val) {
                  setState(() {
                    this.widget.usuario!.recursosOption![Usuario.ExcluirPost] =
                        val!;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
