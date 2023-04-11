import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ConsultaEmpleado.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  _editnoteState({required this.docid});
  TextEditingController Nombre = TextEditingController();
  TextEditingController Cargo = TextEditingController();
  TextEditingController Edad = TextEditingController();
  TextEditingController Telefono = TextEditingController();
  TextEditingController Direccion = TextEditingController();

  File? _image;
  firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref();
  @override
  void initState() {
    Nombre = TextEditingController(text: widget.docid.get('Nombre'));
    Cargo = TextEditingController(text: widget.docid.get('Cargo'));
    Edad = TextEditingController(text: widget.docid.get('Edad'));
    Telefono = TextEditingController(text: widget.docid.get('Telefono'));
    Direccion = TextEditingController(text: widget.docid.get('Direccion'));

    super.initState();
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
                  context, MaterialPageRoute(builder: (_) => Home()));
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
              widget.docid.reference.update({
                'Nombre': Nombre.text,
                'Imagen': url,
                'Cargo': Cargo.text,
                'Edad': Edad.text,
                'Telefono': Telefono.text,
                'Direccion': Direccion.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
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
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final imagePicker = ImagePicker();
                    final pickedFile = await imagePicker.pickImage(
                        source: ImageSource.gallery);
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
                SizedBox(
                  height: 10,
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Edad',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Telefono',
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
