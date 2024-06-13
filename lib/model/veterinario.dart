
class Veterinario {
  final int? id;
  final String bairro;
  final cep;
  final cidade;
  final crmv;
  final String nome;
  final rg;
  final rua;
  final telefone1;
  final telefone2;



  Veterinario({this.id, required this.bairro, required this.cep, required this.cidade, required this.crmv, required this.nome, required this.rg, required this.rua, required this.telefone1, required this.telefone2});

  factory Veterinario.fromJson(Map<String, dynamic> json) {
    return Veterinario(
      id: json['id'],
      bairro: json['bairro'],
      cep: json['cep'],
      cidade: json['cidade'],
      crmv: json['crmv'],
      nome: json['nome'],
      rg: json['rg'],
      rua: json['rua'],
      telefone1: json['telefone1'],
      telefone2: json['telefone2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bairro': bairro,
      'cep': cep,
      'cidade': cidade,
      'crmv': crmv,
      'nome': nome,
      'rg':rg,
      'rua': rua,
      'telefone1':telefone1,
      'telefone2':telefone2,
    };
  }
}