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

class HomeServiceIdentite extends StatefulWidget {
  final String type;
  const HomeServiceIdentite({super.key, required this.type});

  @override
  State<HomeServiceIdentite> createState() => _HomeServiceIdentiteState();
}

class _HomeServiceIdentiteState extends State<HomeServiceIdentite> {
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
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (items[index].type == 'achat') {
                        Get.to(HomeAchat(type: widget.type));
                      } else if (items[index].type == 'demande') {
                        Get.to(HomeSuivi(type: widget.type));
                      } else {
                        Get.to(FormulairePrincipal(type: widget.type));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.white, Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Card(
                            color: Colors.orange.shade400,
                            elevation:
                                1, // désactive l'ombre de la carte pour le remplacer par un ombrage
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  'assets/${items[index].image}',
                                  fit: BoxFit.contain, // pour ajuster l'image
                                  width: double.infinity, // largeur pleine
                                  height: 90, // hauteur de l'image
                                  color: Colors.white,
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  title: Center(
                                      child: Text(
                                    items[index].titre,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
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
