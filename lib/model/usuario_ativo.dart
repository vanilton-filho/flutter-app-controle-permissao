import 'package:controle_permissao_app/model/recurso.dart';
import 'package:intl/intl.dart';

class UsuarioAtivo {
  int? id;
  String? nome;
  String? login;
  String? email;
  DateTime? dataNascimento;
  List<Recurso>? recursos;

  UsuarioAtivo(
      {this.id,
      this.nome,
      this.login,
      this.email,
      this.dataNascimento,
      this.recursos});

  UsuarioAtivo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    login = json['login'];
    email = json['email'];
    dataNascimento = DateFormat('yyyy-MM-dd').parse(json['dataNascimento']);
    if (json['recursos'] != null) {
      recursos = <Recurso>[];
      json['recursos'].forEach((v) {
        recursos!.add(new Recurso.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['login'] = this.login;
    data['email'] = this.email;
    data['dataNascimento'] =
        DateFormat('yyyy-MM-dd').format(this.dataNascimento!);
    data['recursos'] = this.recursos!.map((v) => v.toJson()).toList();
    return data;
  }
}
