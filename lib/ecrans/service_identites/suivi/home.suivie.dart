import 'package:flutter/material.dart';
import 'package:oneci/composants/Input_field.dart';
import 'package:oneci/ecrans/service_identites/suivi/encient.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/form-helper.dart';
import 'package:oneci/widgets/header.dart';

class HomeSuivi extends StatefulWidget {
  final String type;
  const HomeSuivi({super.key, required this.type});

  @override
  State<HomeSuivi> createState() => _HomeSuiviState();
}

class _HomeSuiviState extends State<HomeSuivi> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _nni = "";
  bool hidePassword = true;
  bool isApiCall = false;
  int _selectedValue = 1;
  String? _selectedCountry;
  String _nom = '';
  String _numero = '';
  String _dateNaissance = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            const SizedBox(height: 1),
            const Header(),
            Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: globalFormKey,
                child: _inscriptionUI(context),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _inscriptionUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
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
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                RadioListTile<int>(
                  title: const Text('CNI (Ancien Format)'),
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: const Text('CNI (Nouveau Format)'),
                  value: 2,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        if (_selectedValue == 1)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInputField(
                icon: const Icon(Icons.person),
                label: "numero",
                hint: "Entrez le numéro du récépissé d'enrôlement",
                validator: (onValidateVal) {
                  if (onValidateVal!.isEmpty) {
                    return 'Le numéro du récépissé est requis';
                  }
                  return null;
                },
                onSaved: (onSavedVal) {
                  _numero = onSavedVal.toString().trim();
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Encient(
                              type: "encient",
                            )),
                  );
                },
                child: const Text(
                  "Je n'ai pas mon numéro de récépissé d'enrôlement",
                  style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInputField(
                icon: const Icon(Icons.person),
                label: "nom",
                hint: "Entrez votre nom de famille (ou le nom de votre époux)",
                validator: (onValidateVal) {
                  if (onValidateVal!.isEmpty) {
                    return 'Votre nom de famille est requis';
                  }
                  return null;
                },
                onSaved: (onSavedVal) {
                  _nom = onSavedVal.toString().trim();
                },
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 8),
              CustomInputField(
                icon: const Icon(Icons.person),
                label: "numero",
                hint: "Entrez votre numéro de demande",
                validator: (onValidateVal) {
                  if (onValidateVal!.isEmpty) {
                    return 'Votre numéro de demande est requis';
                  }
                  return null;
                },
                onSaved: (onSavedVal) {
                  _numero = onSavedVal.toString().trim();
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              CustomInputField(
                icon: const Icon(Icons.verified_user),
                label: "Date de naissance",
                hint: "jj-mm-aaaa",
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
              const SizedBox(height: 16),
            ],
          ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 100),
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
