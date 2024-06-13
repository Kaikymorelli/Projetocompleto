
class Pet {
  final int? id;
  final String cor;
  final datanascimento;
  final String nome;
  final num_documento;
  final String raca;


  Pet({this.id, required this.nome, required this.cor, required this.datanascimento, required this.num_documento, required this.raca});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      cor: json['cor'],
      datanascimento: json['datanascimento'],
      nome: json['nome'],
      num_documento: json['num_documento'],
      raca: json['raca'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cor': cor,
      'datanascimento': datanascimento,
      'nome': nome,
      'num_documento': num_documento,
      'raca': raca,
    };
  }
}