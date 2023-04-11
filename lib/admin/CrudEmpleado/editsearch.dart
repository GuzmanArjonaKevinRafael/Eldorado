import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ConsultaEmpleado.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class editnotesearch2 extends StatefulWidget {
  final DocumentReference docRef;

  const editnotesearch2({Key? key, required this.docRef}) : super(key: key);

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editnotesearch2> {
  late DocumentSnapshot docid;
  TextEditingController Nombre = TextEditingController();

  TextEditingController Cargo = TextEditingController();
  TextEditingController Direccion = TextEditingController();
  TextEditingController Edad = TextEditingController();
  TextEditingController Telefono = TextEditingController();
  File? _image;
  firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref();
  @override
  void initState() {
    super.initState();

    widget.docRef.get().then((snapshot) {
      setState(() {
        docid = snapshot;
        Nombre.text = docid.get('Nombre');
        Cargo.text = docid.get('Cargo');
        Direccion.text = docid.get('Direccion');
        Edad.text = docid.get('Edad');
        Telefono.text = docid.get('Telefono');
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const Crudempleado()));
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
            onPressed: () async {
              // Sube la imagen seleccionada por el usuario a Firebase Storage
              String? url;
              if (_image != null) {
                var snapshot = await storageReference
                    .child('images/$_image')
                    .putFile(_image!);
                url = await snapshot.ref.getDownloadURL();
              }
              widget.docRef.update({
                'Nombre': Nombre.text,
                'Imagen': url,
                'Cargo': Cargo.text,
                'Direccion': Direccion.text,
                'Edad': Edad.text,
                'telefono': Telefono.text,
              }).whenComplete(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Crudempleado()));
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Crudempleado()));
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
              ElevatedButton(
                onPressed: () async {
                  final imagePicker = ImagePicker();
                  final pickedFile =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
                child: Text("Seleccionar imagen"),
              ),
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
                "Cargo",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 1, 1, 1),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Cargo,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Cargo',
                  ),
                ),
              ),
              Text(
                "Direccion",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 1, 1, 1),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Direccion,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Direccion',
                  ),
                ),
              ),
              Text(
                "Edad",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 1, 1, 1),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Edad,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Edad',
                  ),
                ),
              ),
              Text(
                "Telefono",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 1, 1, 1),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: Telefono,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Telefono',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
