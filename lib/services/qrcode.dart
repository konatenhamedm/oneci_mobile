


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oneci/ecrans/formulaire_fils_parent.dart';
import 'package:oneci/ecrans/formulaire_principal.dart';
import 'package:oneci/ecrans/service_identites/achat/home.achat.dart';
import 'package:oneci/ecrans/service_identites/suivi/home.suivie.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/form-helper.dart';
import 'package:oneci/widgets/header.dart';

class Qrcode extends StatefulWidget {
  final String type;
  const Qrcode({super.key, required this.type});

  @override
  State<Qrcode> createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  final List<PlaceInfo> items = [
    PlaceInfo("Achat de timbre d'enrôlement", '437532.png', 'achat'),
      PlaceInfo("Suivi des statuts et titres d'enrôlement", '10415.png', 'demande'),
    PlaceInfo("Carte de résidence", '76828.png', 'carteresidence'),
  
  ];

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
      body: Column(
        children: [
          const SizedBox(height: 4),
          const Header(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
             child: Text('fghgjbhfdhbjbb'),
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}

class PlaceInfo {
  final String titre;
  final String image;
  final String type;

  PlaceInfo(this.titre, this.image, this.type);
}
