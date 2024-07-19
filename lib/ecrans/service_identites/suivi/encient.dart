import 'package:flutter/material.dart';
import 'package:oneci/composants/Input_field.dart';
import 'package:oneci/ecrans/service_identites/suivi/home.suivie.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/form-helper.dart';
import 'package:oneci/widgets/header.dart';

class Encient extends StatefulWidget {
  final String type;
  const Encient({super.key, required this.type});

  @override
  State<Encient> createState() => _EncientState();
}

class _EncientState extends State<Encient> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  
  bool hidePassword = true;
  bool isApiCall = false;
  int _selectedValue = 1;
  
  String _nom = '';
  String _prenom = '';
  String _dateNaissance = '';
  

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
            const Header(),
            _inscriptionUISetup(context),
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
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Veuillez renseigner les champs du formulaire ci-dessous\n'
                        'afin d\'obtenir un numéro de dossier qui vous permettra d\'être reçu.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            CustomInputField(
              icon: const Icon(Icons.person),
              label: "nom",
              hint: "Entrez votre nom",
              validator: (onValidateVal) {
                if (onValidateVal!.isEmpty) {
                  return 'Le nom est requis';
                }
                return null;
              },
              onSaved: (onSavedVal) {
                _nom = onSavedVal.toString().trim();
              },
              keyboardType: TextInputType.text,
            ),
            CustomInputField(
              icon: const Icon(Icons.person),
              label: "prenom",
              hint: "Entrez votre prénom",
              validator: (onValidateVal) {
                if (onValidateVal!.isEmpty) {
                  return 'Le prénom est requis';
                }
                return null;
              },
              onSaved: (onSavedVal) {
                _prenom = onSavedVal.toString().trim();
              },
              keyboardType: TextInputType.text,
            ),
            CustomInputField(
              icon: const Icon(Icons.person),
              label: "date de naissance",
              hint: "Entrez votre date de naissance",
              validator: (onValidateVal) {
                if (onValidateVal!.isEmpty) {
                  return 'La date de naissance est requise';
                }
                return null;
              },
              onSaved: (onSavedVal) {
                _dateNaissance = onSavedVal.toString().trim();
              },
              keyboardType: TextInputType.datetime,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeSuivi(type: 'home'),
                  ),
                );
              },
              child: const Text(
                "Je suis en possession d'un numéro récépissé d'enrôlement",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
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
              //Get.to();
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
