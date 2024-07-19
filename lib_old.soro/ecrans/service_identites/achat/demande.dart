import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oneci/ecrans/operateur.dart';

import 'package:oneci/ecrans/verification.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/header.dart';
import 'package:oneci/widgets/form-helper.dart';

class Demande extends StatefulWidget {
  //final String type;
  const Demande({super.key});

  @override
  State<Demande> createState() => _DemandeState();
}

class _DemandeState extends State<Demande> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _nni = "";

  bool hidePassword = true;
  bool isApiCall = false;
  int _selectedValue = 1;

 

  
   

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 1,
            ),
            const Header(),
            Stack(
              children: [
                _inscriptionUISetup(context),
              ],
            ),
           const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _inscriptionUISetup(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: globalFormKey,
        child: _inscriptionUI(context),
      ),
    );
  }

  Widget _inscriptionUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.orange, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     const Text(
                        'Veuillez renseigner les champs du formulaire ci-dessous\n'
                        'afin d\'obtenir un numéro de dossier qui vous permettra d\'être reçu.',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                      ),
                      RadioListTile<int>(
                        title: const Text('Faire une demande de NNI'),
                        value: 1,
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                            Get.to(const Operateur());
                        },
                      ),
                      RadioListTile<int>(
                        title: const Text(
                            'Suivre ma demande'),
                        value: 2,
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                          Get.to(const Operateur());
                        },
                      ),
                      
                    ],
                  ),
                ),
              ),
             
            ],
          ),
        ),
       
        const SizedBox(
          height: 4,
        ),
        Center(
          child: FormHelper.saveButtonNew("Soumettre la demande", () {
            if (validatedSave()) {
              setState(() {
                isApiCall = true;
              });

              Get.to(const Verification());
            }
          }, 65),
        ),
        const SizedBox(
          height: 180,
        ),
      ],
    );
  }

  bool validatedSave() {
    final form = globalFormKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();
        return true;
      }
      return false;
    }
    return false;
  }
}






