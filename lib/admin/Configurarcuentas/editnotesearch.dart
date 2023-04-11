import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Consultarcuentas.dart';

class editnotesearch extends StatefulWidget {
  final DocumentReference docRef;

  const editnotesearch({Key? key, required this.docRef}) : super(key: key);

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editnotesearch> {
  late DocumentSnapshot docid;
  TextEditingController email = TextEditingController();
  TextEditingController rool = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.docRef.get().then((snapshot) {
      setState(() {
        docid = snapshot;
        email.text = docid.get('email');
        rool.text = docid.get('rool');
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
                  context, MaterialPageRoute(builder: (_) => Cuentas()));
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
                'email': email.text,
                'rool': rool.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Cuentas()));
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
                    context, MaterialPageRoute(builder: (_) => Cuentas()));
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
                "Email",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 1, 1, 1),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Rool",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 1, 1, 1),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: rool,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Rool',
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
