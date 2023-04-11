import 'package:eldorado/cliente/reservas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login.dart';

class Cliente extends StatefulWidget {
  const Cliente({super.key});

  @override
  State<Cliente> createState() => ClientetState();
}

class ClientetState extends State<Cliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 109, 0, 1),
        title: const Text('Bienvenido'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          miCardImage(),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Image(
                  image: NetworkImage(
                      'https://prod-be-moon-brand.s3.amazonaws.com/THG_Jade_03_restaurantes_background_3600x1800px_b8206c4c21.jpg'),
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken),
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 255, 149, 0)),
            ),
            ListTile(
              leading: Icon(Icons.dashboard_outlined),
              title: Text('Menu'),
              onTap: () {
                Navigator.pushNamed(context, '/menucliente');
              },
            ),
            ListTile(
              leading: Icon(Icons.event_note),
              title: Text('Reservas'),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new Reservas(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

Card miCardImage() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    margin: EdgeInsets.all(25),
    elevation: 10,
    child: Column(
      children: <Widget>[
        Image(
          image: NetworkImage(
              'https://s3-us-west-2.amazonaws.com/wp-mpro-blog/wp-content/uploads/2017/06/07110843/s3-blog-retener-clientes-restaurante-1-min.jpg'),
        ),
        Container(
          padding: EdgeInsets.all(22),
          child: Text(
              '"Disfruta de una experiencia culinaria excepcional en nuestro restaurante, donde la calidad de los ingredientes y la pasión por la cocina se combinan para crear platos memorables que deleitarán tus sentidos.'),
        ),
      ],
    ),
  );
}
