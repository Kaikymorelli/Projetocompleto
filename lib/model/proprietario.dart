class Proprietario {
  final int? id;
  final String bairro;
  final String cep;
  final String cidade;
  final String cpf;
  final String nome;
  final String rg;
  final String rua;
  final String telefone1;
  final String telefone2;

  Proprietario({this.id, required this.bairro, required this.cep, required this.cidade, required this.cpf, required this.nome, required this.rg, required this.rua, required this.telefone1, required this.telefone2});

  factory Proprietario.fromJson(Map<String, dynamic> json) {
    return Proprietario(
        id: json['id'],
        bairro: json['bairro'],
        cep: json['cep'],
        cidade: json['cidade'],
        cpf: json['cpf'],
        nome: json['nome'],
        rg: json['rg'],
        rua: json['rua'],
        telefone1: json['telefone1'],
        telefone2: json['telefone2']

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bairro': bairro,
      'cep': cep,
      'cidade': cidade,
      'cpf': cpf,
      'nome': nome,
      'rg': rg,
      'rua': rua,
      'telefone1': telefone1,
      'telefone2': telefone2

    };
  }
}