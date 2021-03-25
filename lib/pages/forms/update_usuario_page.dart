import 'package:controle_permissao_app/model/usuario.dart';
import 'package:controle_permissao_app/service/usuario_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UpdateUsuarioPage extends StatefulWidget {
  Usuario? usuario;

  UpdateUsuarioPage({this.usuario});

  @override
  _UpdateUsuarioPageState createState() => _UpdateUsuarioPageState();
}

class _UpdateUsuarioPageState extends State<UpdateUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  // Vai ser utilizado para salvar a data
  DateTime? _initDate = DateTime.now();

  TextEditingController? _datePickerController;
  DateTime? _picked;

  @override
  void initState() {
    DateTime? date =
        DateFormat('yyyy-MM-dd').parse(this.widget.usuario!.dataNascimento!);
    _picked = date;
    String? dataFormatada = DateFormat('dd/MM/yyyy').format(date);
    _datePickerController = TextEditingController(text: dataFormatada);

    if (this.widget.usuario!.recursos!.contains(1))
      this.widget.usuario!.recursosOption![Usuario.EditarPerfil] = true;
    if (this.widget.usuario!.recursos!.contains(2))
      this.widget.usuario!.recursosOption![Usuario.VisualizarPerfil] = true;
    if (this.widget.usuario!.recursos!.contains(3))
      this.widget.usuario!.recursosOption![Usuario.EditarPost] = true;
    if (this.widget.usuario!.recursos!.contains(4))
      this.widget.usuario!.recursosOption![Usuario.VisualizarPost] = true;
    if (this.widget.usuario!.recursos!.contains(5))
      this.widget.usuario!.recursosOption![Usuario.ExcluirPost] = true;

    this.widget.usuario!.recursos = [];
    super.initState();
  }

  @override
  void dispose() {
    // Pra remover da árvore de widgets
    _datePickerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // para evitar o overflowed bottom
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
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
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
          builder: (context) => Form(
            // autovalidateMode: AutovalidateMode.always,
            key: _formKey,

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                        initialValue: this.widget.usuario!.nome!,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Nome Completo',
                            border: OutlineInputBorder()),
                        validator: (String? value) => (value!.isEmpty)
                            ? 'Por favor, forneça o seu nome completo.'
                            : null,
                        // onTap: () => print(),

                        onChanged: (val) {
                          setState(() {
                            this.widget.usuario!.nome = val;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                        initialValue: this.widget.usuario!.login!,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.alternate_email),
                            labelText: 'Login',
                            border: OutlineInputBorder()),
                        validator: (String? value) => (value!.isEmpty)
                            ? 'Por favor, forneça um login'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            this.widget.usuario!.login = val;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                        initialValue: this.widget.usuario!.email!,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            border: OutlineInputBorder()),
                        validator: (String? value) => (value!.isEmpty)
                            ? 'Por favor, forneça um email válido.'
                            : null,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) {
                          setState(() {
                            this.widget.usuario!.email = val;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _datePickerController,
                      readOnly: true,
                      style: _datePickerController!.text == 'dd/mm/aaaa'
                          ? TextStyle(color: Colors.grey)
                          : TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: 'Data de Nascimento',
                          border: OutlineInputBorder()),
                      onTap: () => _selectorDateWidget(),
                      validator: (_) {
                        return (_datePickerController!.text == 'dd/mm/aaaa')
                            ? 'Por favor, forneça a sua data de nascimento'
                            : null;
                      },
                    ),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
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
                              style:
                                  GoogleFonts.robotoCondensed(fontSize: 14.0),
                            )
                          ],
                        ),
                        CheckboxListTile(
                            title: const Text('Editar Perfil'),
                            value: this
                                .widget
                                .usuario!
                                .recursosOption![Usuario.EditarPerfil],
                            onChanged: (bool? val) {
                              setState(() {
                                this
                                        .widget
                                        .usuario!
                                        .recursosOption![Usuario.EditarPerfil] =
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
                                this.widget.usuario!.recursosOption![
                                    Usuario.VisualizarPerfil] = val!;
                              });
                            }),
                        CheckboxListTile(
                            title: const Text('Editar Post'),
                            value: this
                                .widget
                                .usuario!
                                .recursosOption![Usuario.EditarPost],
                            onChanged: (bool? val) {
                              setState(() {
                                this
                                    .widget
                                    .usuario!
                                    .recursosOption![Usuario.EditarPost] = val!;
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
                                this.widget.usuario!.recursosOption![
                                    Usuario.VisualizarPost] = val!;
                              });
                            }),
                        CheckboxListTile(
                            title: const Text('Excluir Post'),
                            value: this
                                .widget
                                .usuario!
                                .recursosOption![Usuario.ExcluirPost],
                            onChanged: (bool? val) {
                              setState(() {
                                this
                                        .widget
                                        .usuario!
                                        .recursosOption![Usuario.ExcluirPost] =
                                    val!;
                              });
                            }),
                      ],
                    ),
                  )),
                  // CheckboxListTile(
                  //     title:
                  //         const Text('Aceito e concordo com os termos de uso'),
                  //     value: _termosDeUso,
                  //     onChanged: (bool? val) {
                  //       setState(() {
                  //         _termosDeUso = val;
                  //       });
                  //     }),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form!.validate()) {
                          DateFormat format = DateFormat("yyyy-MM-dd");

                          this.widget.usuario!.dataNascimento =
                              format.format(_picked!);
                          Map<String, dynamic> usuarioSerialized =
                              this.widget.usuario!.toJson();
                          print(usuarioSerialized);
                          _update(usuarioSerialized);
                        }
                      },
                      child: Text(
                        'Cadastrar',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 21.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(8.0)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.green,
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green,
                        ),

                        // ButtonStyle(
                        //     padding: MaterialStateProperty.all<EdgeInsets>(
                        //         const EdgeInsets.all(8.0)),
                        //     foregroundColor: MaterialStateProperty.all<Color>(
                        //       Colors.grey,
                        //     ),
                        //     backgroundColor: MaterialStateProperty.all<Color>(
                        //       Colors.grey,
                        //     ),
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
          ),
        ),
      ),
    );
  }

  _selectorDateWidget() async {
    DateFormat formatBr = DateFormat("dd/MM/yyyy");

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          DateFormat('yyyy-MM-dd').parse(this.widget.usuario!.dataNascimento!),
      firstDate: DateTime(1900),
      lastDate: _initDate!,
      locale: Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    );

    if (picked != null && picked != _initDate) {
      setState(() {
        _datePickerController!.text = formatBr.format(picked).toString();
      });
    }

    _picked = picked!;
  }

  void _update(Map<String, dynamic> usuarioSerialized) async {
    UsuarioService usuarioService = UsuarioService();
    Usuario usuarioAtualizado =
        await usuarioService.put(this.widget.usuario!.id!, usuarioSerialized);

    final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        content: Container(
            height: 25.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Ok! Usuário foi atualizado com sucesso!',
                  ),
                ],
              ),
            )));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
