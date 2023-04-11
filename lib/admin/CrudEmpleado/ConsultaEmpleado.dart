import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eldorado/cliente/cliente.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eldorado/admin/Configurarcuentas/Consultarcuentas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../login.dart';
import '../CrudReservacion/reservas.dart';
import 'addnote.dart';
import 'buscador.dart';
import 'editnote.dart';
import 'editsearch.dart';
import '../admin.dart';
import 'package:eldorado/admin/CrudReservacion/report.dart';

class Crudempleado extends StatefulWidget {
  const Crudempleado({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Crudempleado> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Student report",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 0, 11, 133),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('empleado').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(32, 38, 85, 0.804),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => addnote()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 109, 0, 1),
        title: Text('Crud Empleado'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              search(context);
            },
          ),
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
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            editnote(docid: snapshot.data!.docs[index]),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //  Text(
                          //         'Nombre: ' +
                          //             snapshot.data!.docChanges[index]
                          //                 .doc['Imagen'],
                          //         style: TextStyle(fontSize: 20),
                          //       ),
                          Image.network(
                            snapshot.data!.docChanges[index].doc['Imagen'],
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(
                              width:
                                  16), // Agregar un espacio entre la imagen y el texto
                          Expanded(
                            // Utilizar Expanded para que el Column ocupe todo el espacio restante en la fila
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nombre: ' +
                                      snapshot.data!.docChanges[index]
                                          .doc['Nombre'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Edad: ' +
                                      snapshot
                                          .data!.docChanges[index].doc['Edad'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Cargo: ' +
                                      snapshot
                                          .data!.docChanges[index].doc['Cargo'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Telefono: ' +
                                      snapshot.data!.docChanges[index]
                                          .doc['Telefono'],
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Direccion: ' +
                                      snapshot.data!.docChanges[index]
                                          .doc['Direccion'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
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

Future<void> search(BuildContext context) async {
  CircularProgressIndicator();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const Buscador2(),
    ),
  );
}
