import 'package:controle_permissao_app/model/usuario.dart';
import 'package:controle_permissao_app/pages/list_recursos.dart';

class UsuarioUtils {
  static ListRecursos getListRecursos(Usuario usuario) {
    return ListRecursos(
      usuario: usuario,
    );
  }
}
