import 'package:flutter/material.dart';
import 'package:pet_go/service/ApiService.dart';
import 'package:pet_go/model/tipo.dart';


class Telatipo extends StatefulWidget {
  @override
  _TelaTipoState createState() => _TelaTipoState();
}

class _TelaTipoState extends State<Telatipo> {
  late Future<List<Tipo>> _tipo;
  final ApiService _apiService = ApiService();

  final TextEditingController _tipoController = TextEditingController();


  Tipo? _tipoAtual;

  @override
  void initState() {
    super.initState();
    _atualizarTipo();
  }

  void _atualizarTipo() {
    setState(() {
      _tipo = _apiService.buscarTipo();
    });
  }

  void _mostrarFormulario({Tipo? tipo}) {
    if (tipo != null) {
      _tipoAtual = tipo;
      _tipoController.text = tipo.tipo;

    } else {
      _tipoAtual = null;
      _tipoController.clear();

    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _tipoController,
              decoration: InputDecoration(labelText: 'Tipo de animal'),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_tipoAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final tipo = _tipoController.text;


    if (_tipoAtual == null) {
      final novoTipo = Tipo(tipo: tipo);
      await _apiService.criarTipo(novoTipo);
    }
    else {
      final TipoAtualizado = Tipo(
        id: _tipoAtual!.id,
        tipo: tipo,

      );
      await _apiService.atualizarTipo(TipoAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarTipo();
  }

  void _deletarProduto(int id) async {
    try {
      await _apiService.deletarTipo(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tipo deletado com sucesso!')));
      _atualizarTipo();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar tipo: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TIPO'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Tipo>>(
        future: _tipo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final tipo = snapshot.data![index];
                return ListTile(
                  title: Text(tipo.tipo),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(tipo: tipo),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarProduto(tipo.id!),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
