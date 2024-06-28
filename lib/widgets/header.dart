import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneci/widgets/header.dart';
import 'package:oneci/widgets/footer.dart';



class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.green, // Couleur de la bordure supérieure
            width: 2.0, // Épaisseur de la bordure supérieure
          ),
        ),
      ),
      child: SizedBox(
        width: 1000,
        height: 78,
        child: Center(child: Image.asset("assets/logo.png",
          height: 70,
          width: 100,
        ),),
      ),
    );
  }
}
