class Especialidade{
  final int? id;
  final String especialidade;


  Especialidade({this.id, required this.especialidade});

  factory Especialidade.fromJson(Map<String, dynamic>json){
    return Especialidade(
        id: json['id'],
        especialidade: json['especialidade']

    );
  }
  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'especialidade': especialidade
    };
  }
}
