import 'package:flutter/material.dart';
import 'package:pet_go/service/PetService.dart';
import 'package:pet_go/model/pet.dart';


class TelaPet extends StatefulWidget {
  @override
  _TelaPetState createState() => _TelaPetState();
}

class _TelaPetState extends State<TelaPet> {
  late Future<List<Pet>> _pet;
  final PetService _petService = PetService();

  final TextEditingController _corController = TextEditingController();
  final TextEditingController _datanascimentoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _num_documentoController = TextEditingController();
  final TextEditingController _racaController = TextEditingController();


  Pet? _petAtual;

  @override
  void initState() {
    super.initState();
    _atualizarPet();
  }

  void _atualizarPet() {
    setState(() {
      _pet = _petService.buscarPet();
    });
  }

  void _mostrarPet({Pet? pet}) {
    if (pet != null) {
      _petAtual = pet;
      _nomeController.text = pet.nome;
      _corController.text = pet.cor;
      _datanascimentoController.text = pet.datanascimento;
      _num_documentoController.text = pet.num_documento;
      _racaController.text = pet.raca;


    } else {
      _petAtual = null;
      _nomeController.clear();
      _corController.clear();
      _datanascimentoController.clear();
      _num_documentoController.clear();
      _racaController.clear();
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
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Cor'),
            ),
            TextField(
              controller: _corController,
              decoration: InputDecoration(labelText: 'DatadeNascimento'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _corController,
              decoration: InputDecoration(labelText: 'Nome'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _corController,
              decoration: InputDecoration(labelText: 'Num_Documento'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _corController,
              decoration: InputDecoration(labelText: 'Raca'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_petAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;
    final cor = _corController.text;
    final datanascimento = _datanascimentoController;
    final num_documento = _num_documentoController;
    final raca = _racaController.text;

    if (_petAtual == null) {
      final novoPet = Pet(nome: nome, cor: cor, datanascimento: datanascimento, num_documento: num_documento, raca: raca);
      await _petService.criarPet(novoPet);
    }
    else {
      final petAtualizado = Pet(
        id: _petAtual!.id,
        nome: nome,
        cor: cor,
        datanascimento: datanascimento,
        num_documento: num_documento,
        raca: raca,
      );
      await _petService.atualizarPet(petAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarPet();
  }

  void _deletarPet(int id) async {
    try {
      await _petService.deletarPet(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pet deletado com sucesso!')));
      _atualizarPet();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar pet: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PETS'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarPet(),
          ),
        ],
      ),
      body: FutureBuilder<List<Pet>>(
        future: _pet,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pet = snapshot.data![index];
                return ListTile(
                  title: Text(pet.nome),
                  subtitle: Text('R\$${pet.cor}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarPet(pet: pet),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarPet(pet.id!),
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
