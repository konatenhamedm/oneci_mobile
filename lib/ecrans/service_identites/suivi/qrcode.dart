import 'package:flutter/material.dart';
import 'package:oneci_app/composants/Input_field.dart';
import 'package:oneci_app/widgets/footer.dart';
import 'package:oneci_app/widgets/form-helper.dart';
import 'package:oneci_app/widgets/header.dart';
import 'package:http/http.dart' as http;

class Qrcode extends StatefulWidget {
  final String type;
  const Qrcode({super.key, required this.type});

  @override
  State<Qrcode> createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _nni = "";

  bool isApiCall = false;
  String _nom = '';
  String _numero = '';
  String _dateNaissance = '';
  String _qrCodeUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1A730),
        leading: IconButton(
          iconSize: 30,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
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
                        " generer le QR Code pour l'impression",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
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
              label: "numero",
              hint: "Entrez votre numéro de demande",
              validator: (onValidateVal) {
                if (onValidateVal!.isEmpty) {
                  return 'Le numéro de demande est requis';
                }
                return null;
              },
              onSaved: (onSavedVal) {
                _numero = onSavedVal.toString().trim();
              },
              keyboardType: TextInputType.number,
            ),
            CustomInputField(
              icon: const Icon(Icons.person),
              label: "nom",
              hint: "Entrez votre nom de famille (ou le nom de votre époux)",
              validator: (onValidateVal) {
                if (onValidateVal!.isEmpty) {
                  return 'Le nom de famille est requis';
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
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            _qrCodeUrl.isNotEmpty ? Image.network(_qrCodeUrl) : Container(),
            // ElevatedButton(
            //   onPressed: () async {
            //     if (globalFormKey.currentState!.validate()) {
            //       globalFormKey.currentState!.save();
            //       String data = generateDataString();
            //       String qrCodeUrl = await generateQRCode(data);
            //       setState(() {
            //         _qrCodeUrl = qrCodeUrl;
            //       });
            //     }
            //   },
            //   child: Text('Generate QR Code'),
            // ),
           SizedBox(height: 30),
           Center(
              child: FormHelper.saveButtonNew("Generate QR Code", () async {
                if (validatedSave() && globalFormKey.currentState!.validate()) {
                   globalFormKey.currentState!.save();
                  String data = generateDataString();
                  String qrCodeUrl = await generateQRCode(data);
                  setState(() {
                    isApiCall = true;
                     _qrCodeUrl = qrCodeUrl;
                  });
                }
              }, 65),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
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

  String generateDataString() {
    return 'Nom: $_nom, Numéro: $_numero, Date de Naissance: $_dateNaissance';
  }
}

Future<String> generateQRCode(String data) async {
  final response = await http.get(
    Uri.parse(
        'http://api.qrserver.com/v1/create-qr-code/?data=$data&size=200x200'),
  );

  if (response.statusCode == 200) {
    return response.request!.url.toString();
  } else {
    throw Exception('Failed to generate QR code');
  }
}
