import 'package:controle_permissao_app/model/usuario.dart';
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

  DateTime? _picked;

  @override
  void dispose() {
    // Pra remover da árvore de widgets
    _datePickerController.dispose();
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
                        // keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            _usuario.senha = val;
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: _datePickerController,
                      readOnly: true,
                      style: _datePickerController.text == 'dd/mm/aaaa'
                          ? TextStyle(color: Colors.grey)
                          : TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: 'Data de Nascimento',
                          border: OutlineInputBorder()),
                      onTap: () => _selectorDateWidget(),
                      validator: (_) {
                        return (_datePickerController.text == 'dd/mm/aaaa')
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
                            value:
                                _usuario.recursosOption![Usuario.EditarPerfil],
                            onChanged: (bool? val) {
                              setState(() {
                                _usuario.recursosOption![Usuario.EditarPerfil] =
                                    val!;
                              });
                            }),
                        CheckboxListTile(
                            title: const Text('Visualizar Perfil'),
                            value: _usuario
                                .recursosOption![Usuario.VisualizarPerfil],
                            onChanged: (bool? val) {
                              setState(() {
                                _usuario.recursosOption![
                                    Usuario.VisualizarPerfil] = val!;
                              });
                            }),
                        CheckboxListTile(
                            title: const Text('Editar Post'),
                            value: _usuario.recursosOption![Usuario.EditarPost],
                            onChanged: (bool? val) {
                              setState(() {
                                _usuario.recursosOption![Usuario.EditarPost] =
                                    val!;
                              });
                            }),
                        CheckboxListTile(
                            title: const Text('Visualizar Post'),
                            value: _usuario
                                .recursosOption![Usuario.VisualizarPost],
                            onChanged: (bool? val) {
                              setState(() {
                                _usuario.recursosOption![
                                    Usuario.VisualizarPost] = val!;
                              });
                            }),
                        CheckboxListTile(
                            title: const Text('Excluir Post'),
                            value:
                                _usuario.recursosOption![Usuario.ExcluirPost],
                            onChanged: (bool? val) {
                              setState(() {
                                _usuario.recursosOption![Usuario.ExcluirPost] =
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

                          _usuario.dataNascimento = format.format(_picked!);
                          Map<String, dynamic> usuarioSerialized =
                              _usuario.toJson();
                          print(usuarioSerialized);
                          _createUsuario(usuarioSerialized);
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
      initialDate: _initDate!,
      firstDate: DateTime(1900),
      lastDate: _initDate!,
      locale: Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    );

    if (picked != null && picked != _initDate) {
      setState(() {
        _datePickerController.text = formatBr.format(picked).toString();
        _picked = picked;
      });
    }
  }

  /**
   * Esse método irá tentar fazer a requisição para
   * a criação de um usuário e se bem sucedido apresentará
   * um bottom sheet com uma mensagem de sucesso.
   */
  void _createUsuario(Map<String, dynamic> usuario) async {
    UsuarioService usuarioService = UsuarioService();
    Usuario usuarioCriado = await usuarioService.post(usuario);

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
        borderRadius: BorderRadius.circular(42.0),
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
