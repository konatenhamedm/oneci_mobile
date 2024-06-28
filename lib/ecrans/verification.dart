import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oneci/ecrans/imprime.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/form-helper.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final String photoUrl = 'https://example.com/photo.jpg'; // Remplacez par l'URL de la photo de la personne
  final String name = 'John Doe';
  final String firstName = 'John';
  final String lastName = 'Doe';
  final String gender = 'Male';
  final String phoneNumber = '+123456789';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1A730),
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Action de retour
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text(
            'Bienvenue sur E-PRINT',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body:  ListView(
        //padding: const EdgeInsets.all(16.0),
        children: <Widget>[
         const  Center(
            child:  Padding(
              padding: EdgeInsets.all(10.0),
              child:  Text(
                'Veuillez vérifier ces informations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Cadre pour la photo d'identité
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              width: double.infinity,
              height: 200,
              child: Card(
                color: Colors.white,
                child: Image.asset(
                  "assets/D-ID-portrait_character.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          // Cadre pour les informations personnelles
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              width: double.infinity,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Nom: $name', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Prénoms: $firstName', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Sexe: $lastName', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('NNI: $gender', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8),
                      Text('Numéro portable: $phoneNumber', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          FormHelper.saveButtonNew('Passer à réconnaissance faciale', (){
            Get.to(Imprime());
          },50),
          const SizedBox(height: 70,),
          const Footer(),
        ],
      ),
    );
  }
}
