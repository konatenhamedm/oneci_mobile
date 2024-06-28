import 'package:flutter/material.dart';
import 'package:oneci/ecrans/formulaire_principal.dart';
import 'package:oneci/ecrans/option_screen.dart';
import 'package:oneci/widgets/footer.dart';
import 'package:oneci/widgets/header.dart';
import 'dart:ui' as ui;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:oneci/widgets/form-helper.dart';

class Operateur extends StatefulWidget {
  const Operateur({super.key});

  @override
  State<Operateur> createState() => _OperateurState();
}

class _OperateurState extends State<Operateur> {
  final double _borderRadius = 24;

  final List<PlaceInfo> items = [
    PlaceInfo("Orange", const Color(0xFF000000), const Color(0xFF000000), 'orange'),
    PlaceInfo("MTN", const Color(0xFFF7C201), const Color(0xFFF7C201), 'mtn'),
    PlaceInfo("Moov", const Color(0xFF0063AD), const Color(0xFF0063AD), 'moov'),
    PlaceInfo("Wave", const Color(0xFF1DC4FF), const Color(0xFF1DC4FF), 'wave'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1A730),
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
          const SizedBox(height: 4,),
          const Header(),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OptionScreen(type: items[index].type)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OptionScreen(type: items[index].type)),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(_borderRadius),
                                gradient: LinearGradient(
                                  colors: [items[index].endColor, items[index].endColor],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 12,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            top: 0,
                            child: CustomPaint(
                              size: const Size(100, 150),
                              painter: CustomCardShapePainter(_borderRadius, items[index].endColor, items[index].endColor),
                            ),
                          ),
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                      'assets/${items[index].type}.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            items[index].name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
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
                  ),
                );
              },
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }
}

class PlaceInfo {
  final String name;
  final Color startColor;
  final Color endColor;
  final String type;

  PlaceInfo(this.name, this.startColor, this.endColor, this.type);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paintShader = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(0, 0),
        Offset(size.width, size.height),
        [
          startColor,
          endColor,
        ],
      );

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paintShader);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
