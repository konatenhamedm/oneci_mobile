import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;
import 'package:oneci/ecrans/home.dart';
import 'package:oneci/ecrans/imprime.dart';
import 'package:oneci/utils/config.dart';

class FaceRecognitionScreen extends StatefulWidget {
  final CameraDescription camera;
  final String nni;
  final String type;

  const FaceRecognitionScreen({Key? key, required this.camera, required this.nni, required this.type}) : super(key: key);

  @override
  _FaceRecognitionScreenState createState() => _FaceRecognitionScreenState();
}

class _FaceRecognitionScreenState extends State<FaceRecognitionScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late FaceDetector _faceDetector;
  List<Face> _faces = [];
  String _message = '';

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _faceDetector = GoogleMlKit.vision.faceDetector();

    _initializeControllerFuture = _controller.initialize().then((_) {
      if (mounted) {
        _controller.startImageStream((CameraImage image) {
          if (_faces.isEmpty) {
            _processCameraImage(image);
          }
        });
      }
    });
  }

  void _processCameraImage(CameraImage image) async {
    if (!mounted) return;

    final inputImage = InputImage.fromBytes(
      bytes: _concatenatePlanes(image.planes),
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.yuv420,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );

    final faces = await _faceDetector.processImage(inputImage);

    if (!mounted) return;

    if (faces.isNotEmpty) {
      final imagePath = await _takePicture();
      final message = await _authenticateFace(imagePath);
      setState(() {
        _faces = faces;
        _message = message;
      });
    } else {
      setState(() {
        _message = 'Aucun visage détecté ,veillez bien vous placer ';
      });
    }
  }

  Future<String> _takePicture() async {
    try {
      final image = await _controller.takePicture();

      if (!mounted) return '';

      return image.path;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<String> _authenticateFace(String imagePath) async {
    if (!mounted) return '';

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${Config.baseUrl.toString()}/compare2'), // Replace with your own API endpoint
    );

    request.files.add(await http.MultipartFile.fromPath('file', imagePath));
    request.fields.addAll({
      "nni": widget.nni
    });

    try {
      final response = await request.send();
      if (!mounted) return 'Widget is not mounted';

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        final match = data['match']; // Retrieve 'match' variable from JSON response

        // Use 'match' as needed
        print('Match result: $match');
        if (match == true) {
          Get.to(Imprime(type: widget.type, nni: widget.nni));
        } else {
          Get.to(const Home());
        }
        return 'Authentication successful: $match';
      } else {
        return 'Authentication failed with status: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error during authentication: $e';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceDetector.close();
    super.dispose();
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
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
            'Reconnaissance faciale',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                CustomPaint(
                  painter: FacePainter(faces: _faces, imageSize: Size(_controller.value.previewSize!.width, _controller.value.previewSize!.height)),
                ),
                if (_message.isNotEmpty)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Text(_message, style: TextStyle(color: Colors.black)),
                    ),
                  ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  final List<Face> faces;
  final Size imageSize;

  FacePainter({required this.faces, required this.imageSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (Face face in faces) {
      final rect = Rect.fromLTRB(
        translateX(face.boundingBox.left, size, imageSize),
        translateY(face.boundingBox.top, size, imageSize),
        translateX(face.boundingBox.right, size, imageSize),
        translateY(face.boundingBox.bottom, size, imageSize),
      );
      canvas.drawRect(rect, paint);
    }
  }

  double translateX(double x, Size size, Size imageSize) {
    return x * size.width / imageSize.width;
  }

  double translateY(double y, Size size, Size imageSize) {
    return y * size.height / imageSize.height;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
