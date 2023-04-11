import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart';
//Importacion de la rutas de admin
import 'package:eldorado/admin/CrudEmpleado/ConsultaEmpleado.dart';
import 'package:eldorado/admin/admin.dart';
//Importacion de la rutas de Cliente
import 'package:eldorado/cliente/cliente.dart';
import 'package:eldorado/cliente/reservas.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        //rutas para admin

        '/crudcliente': (context) => const Crudempleado(),
        '/menu': (context) => const Admin(),

        //rutas para clientes

        '/reservas': (context) => const Reservas(),
        '/menucliente': (context) => const Cliente(),
      },
    );
  }
}
