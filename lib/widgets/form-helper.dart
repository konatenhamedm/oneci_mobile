import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour utiliser les formatters
class FormHelper{


  static Widget inputFieldWidget(
      BuildContext context,
      Icon icon,
      String keyName,
      String labelName,
      Function onValidate,
      Function onSave,
      int? maxLength,
      TextInputType inputType,
      int? minValue, // Nouveau paramètre pour la valeur minimale
      int? maxValue, // Nouveau paramètre pour la valeur maximale// Par défaut, le type est `text`
          {
        String initialValue = "",
        bool obscureText = false,
        Widget? suffixIcon,

      }) {
    List<TextInputFormatter> formatters = [];

    // Vérifier le type de champ et configurer les formatters si le type est `number`
    if (inputType == TextInputType.number) {
      // Vérifier si un intervalle de longueur a été spécifié
      if (minValue != null && maxLength != null) {
        formatters.add(FilteringTextInputFormatter.allow(RegExp(r'^\d{0,' + maxLength.toString() + r'}$')));
      } else if (minValue != null) {
        formatters.add(FilteringTextInputFormatter.digitsOnly);
      }
    }

    return Container(
      height: 65.0,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        initialValue: initialValue,
        key: Key(keyName),
        obscureText: obscureText,
        validator: (val) {
          return onValidate(val);
        },
        onSaved: (val) {
          return onSave(val);
        },
        style: const TextStyle(fontSize: 18),
        keyboardType: inputType, // Type de clavier
        maxLength: maxLength, // Limite de caractères
        inputFormatters: formatters.isNotEmpty ? formatters : null, // Appliquer les formatters si nécessaire
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          hintText: labelName,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.orange,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.orange,
              width: 1,
            ),
          ),
          suffix: suffixIcon,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: IconTheme(
              data: const IconThemeData(color: Colors.green),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }


  static Widget saveButton(
      String buttonText,
      Function onTap
      ){
    return SizedBox(
      height: 45,
      width: 180,
      child: GestureDetector(
        onTap: (){
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10.0),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  static Widget saveButtonNew(
      String buttonText,
      Function onTap,
      double largeur
      ){
    return Container(
      //padding: const EdgeInsets.only(left: 20,right: 20),
      width:1000 ,
      height: 40,
      child:  GestureDetector(
        onTap: (){
          onTap();
        },
        child: Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Couleur de fond du bouton
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Couleur du texte
              shadowColor: MaterialStateProperty.all<Color>(Colors.blueAccent), // Couleur de l'ombre
              elevation: MaterialStateProperty.all<double>(5), // Élévation de l'ombre
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordures arrondies
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsets>(
                 EdgeInsets.symmetric(horizontal: largeur, vertical: 10), // Padding interne
              ),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const  TextStyle(
                  fontSize: 15, // Taille du texte
                  fontWeight: FontWeight.bold, // Épaisseur du texte
                ),
              ),
            ),
            onPressed: () {
             onTap(); // Utilisation de l'expression lambda pour onPressed
              // FormHelper.showMessage2( context,'hgdhgd', "Message", "valid",
              // (){
              // },corps());
            },
            child:  Text(buttonText,style: const TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }
static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPress,

    ){
showDialog(
  context:context,
  builder:(BuildContext context){
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [

        IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close_sharp),
        )
      ],
    );
  }
);
}
static void showMessage2(BuildContext context,
  String title,
  String message,
  String buttonText,
  Function onPress,
    Widget corps,
      )
{
    showDialog(
      context: context,
      barrierDismissible: false, // Empêche la fermeture en cliquant en dehors de l'AlertDialog
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                corps,
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Ferme l'AlertDialog
                  },
                  child: const Text('Fermer'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}