import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oneci/ecrans/verification.dart';
import 'package:oneci/services/services.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/header.dart';
import 'package:oneci/widgets/form-helper.dart';

class FormulairePrincipal extends StatefulWidget {
  final String type;
  const FormulairePrincipal({super.key, required this.type});

  @override
  State<FormulairePrincipal> createState() => _FormulairePrincipalState();
}

class _FormulairePrincipalState extends State<FormulairePrincipal> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _nni = "";

  bool hidePassword = true;
  bool isApiCall = false;

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
            const SizedBox(height: 1),
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
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0), // Ajustez le rayon selon vos besoins
                  child: Image.asset(
                    "assets/imagedemo.jpg",
                    width: 100.0,
                    height: 100.0, // Ajout de height pour que l'image soit bien proportionnée
                    fit: BoxFit.cover, // S'assure que l'image remplit le container
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
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18
                ),
                textAlign: TextAlign.center, // Centrer le texte
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(
              context,
              const Icon(Icons.numbers),
              "NNI",
              "Entrez votre numéro NNI",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Le numéro NNI est requis';
                }
                if (onValidateVal.length < 11) {
                  return 'Le NNI doit avoir 11 chiffres';
                }
                return null;
              },
                  (onSavedVal) {
                _nni = onSavedVal.toString().trim();
              },
              11,
              TextInputType.number,
              0,
              7,
              onError: (error) {
                return 'Le numéro NNI est requis';
                // Gérez l'erreur ici, par exemple en affichant un message à l'utilisateur
                print(error); // Ou utilisez une méthode plus appropriée pour afficher l'erreur
              }
          ),
        ),

        const SizedBox(height: 4),
        Center(
          child: FormHelper.saveButtonNew(
              "Soumettre la demande", () {
            if (validatedSave()) {
              setState(() {
                isApiCall = true;
              });

              try {
                Services.getExistePersonne(_nni).then((response) {
                  setState(() {
                    isApiCall = false;
                  });
                  if (response == true) {
                    Get.to(Verification(type: widget.type, nni: _nni,));
                  } else {
                    FormHelper.showMessage2(context, "Alerte information", "Information", "OK", () {}, Message("Cette ressource est inexistente dans notre base de données"));
                  }
                }).catchError((error) {
                  setState(() {
                    isApiCall = false;
                  });
                  FormHelper.showMessage2(context, "Erreur réseau", "Oops, une erreur est survenue", "OK", () {}, Message("Erreur réseau, veuillez réessayer plus tard"));
                });
              } catch (e) {
                setState(() {
                  isApiCall = false;
                });
                FormHelper.showMessage2(context, "Erreur", "Oops, une erreur est survenue", "OK", () {}, Message("Oops, une erreur est survenue, veuillez réessayer plus tard"));
              }
            }
          }, 65),
        ),
        const SizedBox(height: 180),
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

  static Widget Message(String message) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12
        ),
      ),
    );
  }
}
