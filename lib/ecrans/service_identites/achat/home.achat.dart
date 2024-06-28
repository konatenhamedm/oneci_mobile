import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oneci/ecrans/verification.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/header.dart';
import 'package:oneci/widgets/form-helper.dart';

class HomeAchat extends StatefulWidget {
  final String type;
  const HomeAchat({super.key, required this.type});

  @override
  State<HomeAchat> createState() => _HomeAchatState();
}

class _HomeAchatState extends State<HomeAchat> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _nni = "";

  bool hidePassword = true;
  bool isApiCall = false;
  int _selectedValue = 1;
  String? _selectedCountry;
  final List<String> _countries = ['France', 'Allemagne', 'Autre'];

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
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _inscriptionUISetup(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orange, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Votre demande de titre sera effectuée à partir de :',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      RadioListTile<int>(
                        title: const Text(' Côte d’Ivoire'),
                        value: 1,
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      RadioListTile<int>(
                        title: const Text(
                            'L’international (consulat ou ambassade)'),
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
              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.orange, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<String>(
                        hint: Text('Sélectionnez un pays'),
                        value: _selectedCountry,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCountry = newValue;
                          });
                        },
                        items: _countries.map((String country) {
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(country),
                          );
                        }).toList(),
                      ),
                      if (_selectedCountry == 'Autre')
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Veuillez préciser votre pays',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10, top: 5),
            child: Center(
              child: Text(
                "Saisissez votre numéro national d'identification (NNI)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center, // Centrer le texte
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(
              context,
              const Icon(Icons.verified_user),
              "NNI",
              "Entrez votre numéro NNI", (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return 'Le numero nni est requis';
            }
            return null;
          }, (onSavedVal) {
            _nni = onSavedVal.toString().trim();
          }, 11, TextInputType.number, 0, 7),
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
