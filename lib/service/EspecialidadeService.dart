import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_go/model/especialidade.dart';
class EspecialidadeService{
  static const String baseUrl = 'http://10.121.138.135:8080/especialidade/';

  Future<List<Especialidade>> buscarEspecialidade() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Especialidade.fromJson(item)).toList();
    }else{
      throw Exception('Falha ao carregar tipo');
    }
  }

  Future<void> criarEspecialidade(Especialidade especialidade) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(especialidade.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar especialidade');
    }
  }
  Future<void> atualizarEspecialidade(Especialidade especialidade) async{
    final response = await http.put(
      Uri.parse('$baseUrl${especialidade.id}'),
      headers: <String, String>{'Content-Type' : 'application/json; charset=UTF-8'},
      body: jsonEncode(especialidade.toJson()),
    );
    if(response.statusCode != 200){
      throw Exception('Falha ao atualizar especialidade');
    }
  }
  Future<void> deletarEspecialidade(int id) async{
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if(response.statusCode == 204){
      print('especialidadedeletado com sucesso');
    }else{
      print('Erro ao deletar tipo: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar o especialidade');
    }
  }
}

