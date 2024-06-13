import 'package:flutter/material.dart';
import 'package:pet_go/service/EspecialidadeService.dart';
import 'package:pet_go/model/especialidade.dart';


class Telaespecialidade extends StatefulWidget {
  @override
  _TelaEspecialidadeState createState() => _TelaEspecialidadeState();
}

class _TelaEspecialidadeState extends State<Telaespecialidade> {
  late Future<List<Especialidade>> _especialidade;
  final EspecialidadeService _EspecialidadeService = EspecialidadeService();

  final TextEditingController _especialidadeController = TextEditingController();


  Especialidade? _especialidadeAtual;

  @override
  void initState() {
    super.initState();
    _atualizarEspecialidade();
  }

  void _atualizarEspecialidade() {
    setState(() {
      _especialidade = _EspecialidadeService.buscarEspecialidade();
    });
  }

  void _mostrarFormulario({Especialidade? especialidade}) {
    if (especialidade != null) {
      _especialidadeAtual = especialidade;
      _especialidadeController.text = especialidade.especialidade;

    } else {
      _especialidadeAtual = null;
      _especialidadeController.clear();

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
              controller: _especialidadeController,
              decoration: InputDecoration(labelText: 'especialidade de animal'),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_especialidadeAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final especialidade = _especialidadeController.text;


    if (_especialidadeAtual == null) {
      final novoTipo = Especialidade(especialidade: especialidade);
      await _EspecialidadeService.criarEspecialidade(novoTipo);
    }
    else {
      final EspecialidadeAtualizado = Especialidade(
        id: _especialidadeAtual!.id,
        especialidade: especialidade,

      );
      await _EspecialidadeService.atualizarEspecialidade(EspecialidadeAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarEspecialidade();
  }

  void _deletarProduto(int id) async {
    try {
      await _EspecialidadeService.deletarEspecialidade(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Especialidade deletado com sucesso!')));
      _atualizarEspecialidade();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar especialidade: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESPECIALIDADE'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Especialidade>>(
        future: _especialidade,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final especialidade = snapshot.data![index];
                return ListTile(
                  title: Text(especialidade.especialidade),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(especialidade: especialidade),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarProduto(especialidade.id!),
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
