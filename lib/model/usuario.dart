class Usuario {
  bool? status;

  int? id;
  String? nome;
  String? login;
  String? email;
  String? senha;
  String? dataNascimento;
  List<int>? recursos = [];
  // Os recursos que podemos utilizar no momento de criar um usuário
  static const int EditarPerfil = 1;
  static const int VisualizarPerfil = 2;
  static const int EditarPost = 3;
  static const int VisualizarPost = 4;
  static const int ExcluirPost = 5;

  Map<int, bool>? recursosOption = {
    EditarPerfil: false,
    VisualizarPerfil: false,
    EditarPost: false,
    VisualizarPost: false,
    ExcluirPost: false,
  };

  Usuario({this.nome, this.login, this.email, this.senha, this.dataNascimento});

  Usuario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    nome = json['nome'];
    login = json['login'];
    email = json['email'];
    dataNascimento = json['dataNascimento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['login'] = this.login;
    data['email'] = this.email;
    data['senha'] = this.senha;
    data['dataNascimento'] = this.dataNascimento;
    this.recursosOption!.forEach((key, value) {
      if (value) recursos!.add(key);
    });
    data['recursos'] = this.recursos;
    return data;
  }
}
