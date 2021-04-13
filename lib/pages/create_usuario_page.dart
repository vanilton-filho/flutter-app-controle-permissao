import 'package:controle_permissao_app/model/usuario.dart';
import 'package:controle_permissao_app/pages/usuario_utils.dart';
import 'package:controle_permissao_app/pages/widgets/custom_button.dart';
import 'package:controle_permissao_app/pages/widgets/custom_date_outline_form_field.dart';
import 'package:controle_permissao_app/service/usuario_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CreateUsuarioPage extends StatefulWidget {
  @override
  _CreateUsuarioPageState createState() => _CreateUsuarioPageState();
}

class _CreateUsuarioPageState extends State<CreateUsuarioPage> {
  final _usuario = Usuario();
  final _formKey = GlobalKey<FormState>();
  // Vai ser utilizado para salvar a data
  DateTime? _initDate = DateTime.now();

  final _datePickerController = TextEditingController(text: 'dd/mm/aaaa');

  TextEditingController? _picked = TextEditingController();

  @override
  void dispose() {
    // Pra remover da árvore de widgets
    _picked!.dispose();
    _datePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // para evitar o overflowed bottom
      backgroundColor: Colors.white,

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
                            _usuario.nome = val;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.alternate_email),
                            labelText: 'Login',
                            border: OutlineInputBorder()),
                        validator: (String? value) => (value!.isEmpty)
                            ? 'Por favor, forneça um login'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            _usuario.login = val;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
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
                            _usuario.email = val;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.remove_red_eye_sharp),
                            labelText: 'Senha',
                            border: OutlineInputBorder()),
                        validator: (String? value) => (value!.length < 8)
                            ? 'A senha precisa ter mais de 8 caracteres.'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            _usuario.senha = val;
                          });
                        }),
                  ),
                  CustomDateOutlineFormField(
                    labelText: 'Data de Nascimento',
                    controller: _datePickerController,
                    initDate: _initDate,
                    messageError: 'Forneça uma data de nascimento',
                    output: _picked,
                  ),
                  UsuarioUtils.getListRecursos(_usuario),
                  CustomButton(
                    label: 'Cadastrar',
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                        _usuario.dataNascimento =
                            DateFormat('yyyy-MM-dd').parse(_picked!.text);
                        Map<String, dynamic> usuarioJson = _usuario.toJson();
                        _createUsuario(usuarioJson);
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

  /**
   * Esse método irá tentar fazer a requisição para
   * a criação de um usuário e se bem sucedido apresentará
   * um bottom sheet com uma mensagem de sucesso.
   */
  void _createUsuario(Map<String, dynamic> usuarioJson) async {
    UsuarioService usuarioService = UsuarioService();
    Usuario usuarioCriado = await usuarioService.post(usuarioJson);

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.only(top: 42.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 68.0,
                  ),
                ),
                Text(
                  '@${usuarioCriado.login}, uhuuu!',
                  style: GoogleFonts.roboto(
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Wrap(
                    children: [
                      Text(
                        'Ficamos felizes de ter agora você conosco, aproveite o nosso app ;)',
                        style: GoogleFonts.roboto(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(42.0), topRight: Radius.circular(42.0)),
      ),
    );

    // Quando tudo acabar, volta pra HomePage meu fio
    Navigator.popAndPushNamed(context, '/');
  }

  _existRecursoMarked() {
    return _usuario.recursosOption![Usuario.EditarPerfil]! ||
        _usuario.recursosOption![Usuario.VisualizarPerfil]! ||
        _usuario.recursosOption![Usuario.EditarPost]! ||
        _usuario.recursosOption![Usuario.VisualizarPost]! ||
        _usuario.recursosOption![Usuario.ExcluirPost]!;
  }
}
