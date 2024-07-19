import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/header.dart';
import 'package:oneci/widgets/form-helper.dart';

class FormulaireFilsParent extends StatefulWidget {
  final String type;
  const FormulaireFilsParent({super.key,required this.type});

  @override
  State<FormulaireFilsParent> createState() => _FormulaireFilsParentState();
}

class _FormulaireFilsParentState extends State<FormulaireFilsParent> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _nni_parent = "";
  String _nni_enfant = " ";

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
            const SizedBox(height: 1,),
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
        const SizedBox(height: 10,),
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
            const Icon(Icons.verified_user),
            "nni_parent",
            "Entrez le NNI du parent",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return 'Le NNI du parent est requis';
              }
              return null;
            },
                (onSavedVal) {
              _nni_parent = onSavedVal.toString().trim();
            },11
              ,TextInputType.number,0,9
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 20),
          child: FormHelper.inputFieldWidget(
            context,
            const Icon(Icons.verified_user),
            "nni_enfant",
            "Entrez le NNI de l'enfant",
                (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Le NNI de l'enfant est requis";
              }
              return null;
            },
                (onSavedVal) {
              _nni_enfant = onSavedVal.toString().trim();
            },11,
              TextInputType.number,0,9
          ),
        ),
        const SizedBox(height: 20,),
        Center(
          child: FormHelper.saveButtonNew(
              "Soumettre la demande", () {
            if (validatedSave()) {
              setState(() {
                isApiCall = true;
              });
            }
          },65),
        ),
        const SizedBox(height: 80,),
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
