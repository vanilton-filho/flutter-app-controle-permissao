import 'dart:convert' as convert;
import 'dart:io';

import 'package:controle_permissao_app/model/usuario.dart';
import 'package:http/http.dart' as http;

/// Classe de serviço responsável por pelo endpoint de usuários
class UsuarioService {
  final String baseURL = "192.168.0.111:8080";

  /// Desserializa o JSON recebido [responseBody] para uma lista de usuários ativos
  List<Usuario> toUsuarios(String responseBody) {
    final json = convert.json.decode(responseBody);
    return json.map<Usuario>((json) => Usuario.fromJson(json)).toList();
  }

  Usuario toUsuario(String responseBody) {
    final json = convert.json.decode(responseBody);
    return Usuario.fromJson(json);
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
        return toUsuarios(response.body);
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
        return toUsuario(response.body);
      } else {
        throw Exception('Indisponível salvar usuário');
      }
    } catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<Usuario> put(int id, Map<String, dynamic> payload) async {
    Uri uri = Uri.http(baseURL, "/usuarios/$id");
    try {
      final response = await http.put(uri,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: convert.json.encode(payload));
      if (response.statusCode == 200) {
        return toUsuario(response.body);
      } else {
        throw Exception('Indisponível atualizar usuário');
      }
    } catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<bool> ativar(int id) async {
    Uri uri = Uri.http(baseURL, "/usuarios/$id/ativo");
    try {
      final response = await http.put(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      return response.statusCode == 204 ? true : false;
    } catch (e) {
      throw SocketException(e.toString());
    }
  }

  Future<bool> desativar(int id) async {
    Uri uri = Uri.http(baseURL, "/usuarios/$id/ativo");
    try {
      final response = await http.delete(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      return response.statusCode == 204 ? true : false;
    } catch (e) {
      throw SocketException(e.toString());
    }
  }
}
