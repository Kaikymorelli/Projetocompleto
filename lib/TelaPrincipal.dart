import 'package:flutter/material.dart';
import 'package:pet_go/telas/TelaTipo.dart';
import 'package:pet_go/telas/TelaEspecialidade.dart';
import 'package:pet_go/telas/TelaPet.dart';
import 'package:pet_go/telas/TelaVeterinario.dart';
import 'package:pet_go/telas/TelaProprietario.dart';

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PET GO'),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: Text(
                'Menu Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('TIPOS'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Telatipo()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('ESPECIALIDADE'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Telaespecialidade()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.list),
              title: Text('PET'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaPet()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('PROPRIETARIOS'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaProprietarios()),
                );
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Text('Bem-vindo à Tela Principal!',
            style: TextStyle(color: Colors.black,fontSize: 20,)
        ),
      ),
    );
  }
}