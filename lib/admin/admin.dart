import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'CrudEmpleado/ConsultaEmpleado.dart';
import './Configurarcuentas/Consultarcuentas.dart';
import '../login.dart';
import 'CrudReservacion/reservas.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    String networkImage =
        'https://prod-be-moon-brand.s3.amazonaws.com/THG_Jade_03_restaurantes_background_3600x1800px_b8206c4c21.jpg';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 109, 0, 1),
        title: const Text('Administrador'),
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
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new Admin(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.create),
              title: Text('Crud Empleado'),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new Crudempleado(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.create),
              title: Text('Crud Reservacion'),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new CrudReservas(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.manage_accounts),
              title: Text('Configurar cuentas'),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new Cuentas(),
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
              'https://www.excelsior.edu/wp-content/uploads/2022/08/22-531960_Network-Administrator_1000x568-1000x568.jpg'),
        ),
        Container(
          padding: EdgeInsets.all(22),
          child: Text(
              '"¡Hola Administradores! Espero que se encuentren bien. Solo quería recordarles lo importante que es su rol en la empresa y lo valioso que es su trabajo. Como administradores, tienen la responsabilidad de asegurarse de que todo en la empresa funcione sin problemas y de que se tomen las decisiones correctas para el beneficio de todos. Por favor, recuerden siempre mantener la ética profesional, la transparencia y la honestidad en todas sus acciones. ¡Gracias por todo lo que hacen!.'),
        ),
      ],
    ),
  );
}
