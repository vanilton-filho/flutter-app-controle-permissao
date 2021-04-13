import 'package:controle_permissao_app/model/usuario.dart';
import 'package:controle_permissao_app/pages/usuario_utils.dart';
import 'package:controle_permissao_app/pages/widgets/custom_button.dart';
import 'package:controle_permissao_app/pages/widgets/custom_date_outline_form_field.dart';
import 'package:controle_permissao_app/service/usuario_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateUsuarioPage extends StatefulWidget {
  Usuario? usuario;

  UpdateUsuarioPage({this.usuario});

  @override
  _UpdateUsuarioPageState createState() => _UpdateUsuarioPageState();
}

class _UpdateUsuarioPageState extends State<UpdateUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _datePickerController;
  TextEditingController? _picked;

  @override
  void initState() {
    DateTime? date = this.widget.usuario!.dataNascimento!;
    _picked = TextEditingController(text: date.toString());
    String? dataFormatada = DateFormat('dd/MM/yyyy').format(date);
    _datePickerController = TextEditingController(text: dataFormatada);

    _initRecursosOption();
    super.initState();
  }

  @override
  void dispose() {
    // Pra remover da árvore de widgets
    _datePickerController!.dispose();
    _picked!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // para evitar o overflowed bottom
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
                  CustomDateOutlineFormField(
                    labelText: 'Data de Nascimento',
                    controller: _datePickerController,
                    initDate: this.widget.usuario!.dataNascimento!,
                    messageError: 'Forneça uma data de nascimento',
                    output: _picked,
                  ),
                  UsuarioUtils.getListRecursos(this.widget.usuario!),
                  CustomButton(
                    label: 'Atualizar',
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                        this.widget.usuario!.dataNascimento =
                            DateFormat('yyyy-MM-dd').parse(_picked!.text);
                        Map<String, dynamic> usuarioJson =
                            this.widget.usuario!.toJson();
                        _updateUsuario(usuarioJson);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateUsuario(Map<String, dynamic> usuarioJson) async {
    UsuarioService usuarioService = UsuarioService();
    Usuario usuarioAtualizado =
        await usuarioService.put(this.widget.usuario!.id!, usuarioJson);

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
                    'Ok! usuário foi atualizado com sucesso!',
                  ),
                ],
              ),
            )));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _initRecursosOption() {
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
  }
}
