import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oneci/controllers/peronne_controller.dart';
import 'package:oneci/ecrans/face_recognition_screen.dart';
import 'package:oneci/ecrans/imprime.dart';
import 'package:oneci/main.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/form-helper.dart';

class Verification extends StatefulWidget {
  final String type,nni;
  const Verification({super.key,required this.type,required this.nni});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final String photoUrl = 'https://example.com/photo.jpg'; // Remplacez par l'URL de la photo de la personne
  final String name = 'Oneci';
  final String firstName = 'Oneci';
  final String lastName = 'Oneci';
  final String gender = 'Home';
  final String phoneNumber = '+2250778887541';

  final PersonneController personneController = Get.put(PersonneController());
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await personneController.fetchVerification(nni: widget.nni);

    });
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
      body:  Center(
        child: Obx((){
          if(personneController.isLoading.value){
            return  const Center(
              child: CircularProgressIndicator(),
            );
          }else{

            return ListView(
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
                      surfaceTintColor:Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.network(
                          personneController.infoData.value.image.toString(),
                          fit: BoxFit.cover,
                        ),
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
                      surfaceTintColor:Colors.white,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Nom: ${personneController.infoData.value.nom.toString()}', style: const TextStyle(fontSize: 18)),
                           const SizedBox(height: 8),
                            Text('Prénoms: ${personneController.infoData.value.prenoms.toString()}', style:const  TextStyle(fontSize: 18)),
                           const  SizedBox(height: 8),
                            Text('Sexe: ${personneController.infoData.value.nom.toString()}', style:const  TextStyle(fontSize: 18)),
                            const SizedBox(height: 8),
                            Text('NNI: ${personneController.infoData.value.numero.toString()}', style: const TextStyle(fontSize: 18)),
                           const  SizedBox(height: 8),
                            Text('Numéro portable: ${personneController.infoData.value.nom.toString()}', style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                FormHelper.saveButtonNew('Passer à réconnaissance faciale', () async{
                  final cameras = await availableCameras();
                  final firstCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
                  Get.to(FaceRecognitionScreen(camera: firstCamera,nni: widget.nni,type: widget.type,));
                },50),
                const SizedBox(height: 70,),
                const Footer(),
              ],
            );
          }
        }),
      )
    );
  }
}
