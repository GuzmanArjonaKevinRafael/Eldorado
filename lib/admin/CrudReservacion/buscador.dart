import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'editsearch.dart';
import 'reservas.dart';
import 'package:eldorado/admin/Configurarcuentas/Consultarcuentas.dart';
import 'package:eldorado/admin/CrudEmpleado/ConsultaEmpleado.dart';
import 'package:eldorado/admin/admin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const CrudReservas());
}

class Buscador3 extends StatelessWidget {
  const Buscador3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirebaseSearchScreen(),
    );
  }
}

class FirebaseSearchScreen extends StatefulWidget {
  const FirebaseSearchScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseSearchScreen> createState() => _FirebaseSearchScreenState();
}

class _FirebaseSearchScreenState extends State<FirebaseSearchScreen> {
  List<DocumentSnapshot> searchResult = [];
  bool showOnlyAdmin = false;

  void searchFromFirebase(String query) async {
    Query collectionQuery = FirebaseFirestore.instance
        .collection('report')
        .where('Nombre', isEqualTo: query);
    // Agregar este campo para buscar el valor "admin" en "rool"

    final result = await collectionQuery.get();

    setState(() {
      searchResult = result.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservaciones"),
        backgroundColor: Color.fromRGBO(255, 109, 0, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              menu(context);
            },
          ),
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
                    builder: (context) => new Crudempleado(),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Buscar",
              ),
              onChanged: (query) {
                searchFromFirebase(query);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => editnotesearch(
                          docRef: searchResult[index].reference,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(searchResult[index]['Nombre']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Fecha de registro: ${searchResult[index]['Fecha']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Mesa asignada: ${searchResult[index]['Mesa']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> menu(BuildContext context) async {
    CircularProgressIndicator();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CrudReservas(),
      ),
    );
  }
}
