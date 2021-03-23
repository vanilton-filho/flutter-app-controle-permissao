import 'dart:convert' as convert;
import 'dart:io';

import 'package:controle_permissao_app/model/usuario_ativo.dart';
import 'package:http/http.dart' as http;

/// Classe de serviço responsável por pelo endpoint de usuários
class UsuarioAtivoService {
  /// Desserializa o JSON recebido [responseBody] para uma lista de usuários ativos
  List<UsuarioAtivo> parseUsuarios(String responseBody) {
    final json = convert.json.decode(responseBody);
    return json
        .map<UsuarioAtivo>((json) => UsuarioAtivo.fromJson(json))
        .toList();
  }

  /// Obtém uma lista de usuários ativos
  Future<List<UsuarioAtivo>> fetchUsuarios() async {
    Uri uri = Uri.http("192.168.0.111:8080", "/usuarios/ativos");
    try {
      final response = await http.get(
        uri,
        headers: {
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        return parseUsuarios(response.body);
      } else {
        throw Exception('Indisponível buscar usuários ativos da REST API');
      }
    } catch (e) {
      throw SocketException("Não foi possível estabelecer conexão com a API");
    }
  }

  // UsuarioAtivo create() {}
}
