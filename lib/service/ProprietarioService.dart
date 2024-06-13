import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_go/model/Proprietario.dart';

class ProprietarioService {
  static const String baseUrl = 'http://10.121.138.135:8080/proprietario/';

  Future<List<Proprietario>> buscarProprietario() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Proprietario.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar proprietario');
    }
  }
  Future<void> criarProprietario(Proprietario proprietario) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(proprietario.toJson()),
    );
    if (response.statusCode !=201) {
      throw Exception('Falha ao criar proprietario');
    }
  }

  Future<void> atualizarProprietario(Proprietario proprietario) async {
    final response = await http.put(
      Uri.parse('$baseUrl${proprietario.id}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(proprietario.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar proprietario');
    }
  }

  Future<void> deletarProprietario(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 204) {
      print('Proprietario deletado com sucesso');
    } else {
      print('Erro ao deletar proprietario: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar proprietario');
    }
  }
}
