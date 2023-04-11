import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'reservas.dart';

class editnotesearch extends StatefulWidget {
  final DocumentReference docRef;

  const editnotesearch({Key? key, required this.docRef}) : super(key: key);

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editnotesearch> {
  late DocumentSnapshot docid;
  TextEditingController Nombre = TextEditingController();
  TextEditingController Fecha = TextEditingController();
  TextEditingController Mesa = TextEditingController();
  @override
  void initState() {
    super.initState();

    widget.docRef.get().then((snapshot) {
      setState(() {
        docid = snapshot;
        Nombre.text = docid.get('Nombre');
        Fecha.text = docid.get('Fecha');
        Mesa.text = docid.get('Mesa');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 109, 0, 1),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => CrudReservas()));
            },
            child: Text(
              "Salir",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docRef.update({
                'Nombre': Nombre.text,
                'Fecha': Fecha.text,
                'Mesa': Mesa.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => CrudReservas()));
              });
            },
            child: Text(
              "Guardar",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docRef.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => CrudReservas()));
              });
            },
            child: Text(
              "Eliminar",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Nombre",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 1, 1, 1),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Nombre,
                  decoration: InputDecoration(
                    hintText: 'Nombre',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Fecha",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 1, 1, 1),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Fecha,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Fecha',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Mesa",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 1, 1, 1),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Mesa,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Mesa',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
