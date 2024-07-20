import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oneci/ecrans/face_recognition_screen.dart';
import 'package:oneci/ecrans/operateur.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/form-helper.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Validation extends StatefulWidget {
  final String code,type,nni,operateur,nombre;
  const Validation({super.key, required this.code,required this.type,required this.nni,required this.nombre,required this.operateur});

  @override
  State<Validation> createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _numero = "";
  String _code= "";

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
      body: _inscriptionUISetup(context),
    );
  }

  Widget _inscriptionUISetup(BuildContext context) {
    return Form(
      key: globalFormKey,
      child: _formulaire(context),
    );
  }

  Widget _formulaire(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.green],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Card(
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    elevation: 8.0,
                    margin: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child:  Text(
                              'Faites le ${widget.code.toString()}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          FormHelper.inputFieldWidget(
                              context,
                              const Icon(Icons.phone),
                              "numero",
                              "Entrez votre numéro de tel",
                                  (onValidateVal) {
                                if (onValidateVal.isEmpty) {
                                  return 'Le numero est requis';
                                }
                                if (onValidateVal.length < 10) {
                                  return 'Le numéro doit être 10 chiffres';
                                }
                                return null;
                              },
                                  (onSavedVal) {
                                _numero = onSavedVal.toString().trim();
                              }, 10,
                              TextInputType.number,
                              0, 9
                          ),
                          const SizedBox(height: 5,),
                          FormHelper.inputFieldWidget(
                              context,
                              const Icon(Icons.key),
                              "code",
                              "Entrez le code",
                                  (onValidateVal) {
                                if (onValidateVal.isEmpty) {
                                  return 'Le code est requis';
                                }
                                if (onValidateVal.length < 3) {
                                  return 'Le code est requis';
                                }
                                return null;
                              },
                                  (onSavedVal) {
                                _code = onSavedVal.toString().trim();
                              }, 5,
                              TextInputType.number,
                              0, 9
                          ),
                          const SizedBox(height: 16.0),
                          FormHelper.saveButtonNew('Soumettre', () async {
                            final cameras = await availableCameras();
                            final firstCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
                            if (validatedSave()) {
                              setState(() {
                                isApiCall = true;
                              });

                              Get.to(FaceRecognitionScreen(camera: firstCamera,nni: widget.nni,type: widget.type,));
                            }

                          }, 65),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.green],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Card(
                    surfaceTintColor: Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset('assets/qr.png',
                            height: 200,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80,),
          const Footer(),
        ],
      ),
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
