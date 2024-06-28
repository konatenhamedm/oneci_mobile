import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oneci/ecrans/operateur.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/form-helper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class Imprime extends StatefulWidget {
  const Imprime({Key? key}) : super(key: key);

  @override
  State<Imprime> createState() => _ImprimeState();
}

class _ImprimeState extends State<Imprime> {
  final TextEditingController _controller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String _nombre = "";

  bool hidePassword = true;
  bool isApiCall = false;
  String _path = "";

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/chart.pdf');
      final String dir = (await getApplicationDocumentsDirectory()).path;
      final String path = '$dir/chart.pdf';
      final File file = File(path);
      await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
      setState(() {
        _path = path;
      });
    } catch (e) {
      print("Error loading PDF: $e");
    }
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
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: _path.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.green, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),

                ),
                child: Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.all(5.0),
                  child: PDFView(filePath: _path),
                ),
              ),
            )
                : const Center(child:  CircularProgressIndicator()),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Container(

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.green, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),

                ),
                child: Card(
                  color: Colors.white,
                  elevation: 8.0,
                  margin: EdgeInsets.all(5.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormHelper.inputFieldWidget(
                            context,
                            const Icon(Icons.verified_user),
                            "nombre",
                            "Entrez le nombre de copies",
                                (onValidateVal) {
                              if (onValidateVal.isEmpty) {
                                return 'Le numero nni est requis';
                              }
                              return null;
                            },
                                (onSavedVal) {
                              _nombre = onSavedVal.toString().trim();
                            },1,
                            TextInputType.number,
                            0,7
                        ),
                        const SizedBox(height: 16.0),
                        FormHelper.saveButtonNew('Valider et Continuer', (){
                          Get.to(Operateur());
                        }, 65),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}