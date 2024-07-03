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
  final List<String> _countries = [
    'France',
    'Allemagne',
    'Veuillez préciser votre pays'
  ];

  void _showModal(int value) {
    Widget modalContent;
    switch (value) {
      case 3:
        modalContent = DuplicataCNI();
        break;
      case 4:
        modalContent = NouvelleCNI();
        break;
      case 5:
        modalContent = RenouvellementCNI();
        break;
      default:
        modalContent = Text('Option inconnue');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Option sélectionnée'),
          content: modalContent,
          actions: <Widget>[
            TextButton(
              child: Text('oui'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             TextButton(
              child: Text('nom'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
            mainAxisAlignment: MainAxisAlignment.start,
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
                      const Text(
                        'Votre demande de titre sera effectuée à partir de:',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      RadioListTile<int>(
                        title: const Text('Côte d’Ivoire'),
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
                      if (_selectedValue == 2)
                        Card(
                          child: Column(
                            children: [
                              const Text(
                                'Sélectionnez un pays',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
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
                            ],
                          ),
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Pays de residence',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          RadioListTile<int>(
                            title: const Text('Duplicata CNI'),
                            value: 3,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value!;
                                _showModal(value);
                              });
                            },
                          ),
                          RadioListTile<int>(
                            title: const Text('Nouvelle CNI'),
                            value: 4,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value!;
                                _showModal(value);
                              });
                            },
                          ),
                          RadioListTile<int>(
                            title: const Text('Renouvellement CNI'),
                            value: 5,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value!;
                                _showModal(value);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // const Center(
        //   child: Padding(
        //     padding: EdgeInsets.only(bottom: 10, top: 5),
        //     child: Center(
        //       child: Text(
        //         "Saisissez votre numéro national d'identification (NNI)",
        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        //         textAlign: TextAlign.center, // Centrer le texte
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(
              context, const Icon(Icons.person), "Nom", " Nom de famille",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return 'Le nom de famille est requis';
            }
            return null;
          }, (onSavedVal) {
            _nni = onSavedVal.toString().trim();
          }, 11, TextInputType.number, 0, 7),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(
              context, const Icon(Icons.person), "Prénom(s)", "Votre Prénom",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return 'Le Prénom est requis';
            }
            return null;
          }, (onSavedVal) {
            _nni = onSavedVal.toString().trim();
          }, 11, TextInputType.number, 0, 7),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(
              context,
              const Icon(Icons.verified_user),
              "datenaissance",
              " jj-mm-aaaa", (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return 'Le numero nni est requis';
            }
            return null;
          }, (onSavedVal) {
            _nni = onSavedVal.toString().trim();
          }, 11, TextInputType.datetime, 0, 7),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(
              context,
              const Icon(Icons.verified_user),
              "lieunaissance",
              "Lieu de naissance", (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return 'Le numero nni est requis';
            }
            return null;
          }, (onSavedVal) {
            _nni = onSavedVal.toString().trim();
          }, 11, TextInputType.number, 0, 7),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(
              context, const Icon(Icons.person), "nommere", "Nom de la mère",
              (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return 'Le Nom de la mère  est requis';
            }
            return null;
          }, (onSavedVal) {
            _nni = onSavedVal.toString().trim();
          }, 11, TextInputType.text, 0, 7),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(context, const Icon(Icons.person),
              "prenommere", "Prénom de la mère", (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return 'Le prénom de la mère  est requis';
            }
            return null;
          }, (onSavedVal) {
            _nni = onSavedVal.toString().trim();
          }, 11, TextInputType.text, 0, 7),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(
              context,
              const Icon(Icons.verified_user),
              "Telephone",
              "Telephone", (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return 'Le Telephone  est requis';
            }
            return null;
          }, (onSavedVal) {
            _nni = onSavedVal.toString().trim();
          }, 11, TextInputType.number, 0, 7),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(
              context,
              const Icon(Icons.verified_user),
              "adresse",
              "Adresse Email", (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return ' Adresse Email est requis';
            }
            return null;
          }, (onSavedVal) {
            _nni = onSavedVal.toString().trim();
          }, 11, TextInputType.text, 0, 7),
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
class DuplicataCNI extends StatefulWidget {
  @override
  State<DuplicataCNI> createState() => _DuplicataCNIState();
}

class _DuplicataCNIState extends State<DuplicataCNI> {
  @override
   final _formKey = GlobalKey<FormState>();

  final _nniController = TextEditingController();

  @override
  void dispose() {
    _nniController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Formulaire pour Duplicata CNI'),
        
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cible:\n'
                'Ivoiriens dont la CNI se trouve dans un contexte de :\n'
                '- Perte\n'
                '- Vol\n'
                '- Dégradation\n'
                'Dans le processus de demande, vous aurez à fournir votre NNI lié à la CNI concernée.',
                style: TextStyle(fontSize: 16),
              ),
             
             
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: Text('oui'),
                    ),

                     ElevatedButton(
                      onPressed: () {
                       Navigator.of(context).pop();
                      },
                      child: Text('non'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Ajoutez d'autres champs de formulaire si nécessaire
      ],
    );
  }
}

class NouvelleCNI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Formulaire pour Nouvelle CNI'),
        TextField(
          decoration: InputDecoration(labelText: 'Nom complet'),
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Date de naissance'),
        ),
        // Ajoutez d'autres champs de formulaire si nécessaire
      ],
    );
  }
}

class RenouvellementCNI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Formulaire pour Renouvellement CNI'),
        TextField(
          decoration: InputDecoration(labelText: 'Nom complet'),
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Numéro de CNI actuel'),
        ),
        // Ajoutez d'autres champs de formulaire si nécessaire
      ],
    );
  }
}
