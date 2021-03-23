import 'dart:convert' as convert;
import 'dart:io';

import 'package:controle_permissao_app/model/usuario.dart';
import 'package:http/http.dart' as http;

/// Classe de serviço responsável por pelo endpoint de usuários
class UsuarioService {
  final String baseURL = "192.168.0.111:8080";

  /// Desserializa o JSON recebido [responseBody] para uma lista de usuários ativos
  List<Usuario> parseUsuarios(String responseBody) {
    final json = convert.json.decode(responseBody);
    return json.map<Usuario>((json) => Usuario.fromJson(json)).toList();
  }

  Usuario parseUsuario(String responseBody) {
    final json = convert.json.decode(responseBody);
    return Usuario.fromJson(json);
    // return json.map<String, dynamic>((json) => Usuario.fromJson(json));
  }

  Future<List<Usuario>> fetchUsuarios() async {
    Uri uri = Uri.http(baseURL, "/usuarios");
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

  Future<Usuario> post(Map<String, dynamic> payload) async {
    Uri uri = Uri.http(baseURL, "/usuarios");
    try {
      final response = await http.post(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: convert.json.encode(payload));
      if (response.statusCode == 201) {
        print(response.body);
        return parseUsuario(response.body);
      } else {
        throw Exception('Indisponível buscar usuários ativos da REST API');
      }
    } catch (e) {
      throw SocketException(e.toString());
    }
  }
}
