import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:oneci/widgets/form-helper.dart';


class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Video demo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: 'https://www.youtube.com/watch?v=_A0fWBHu9pM&list=RDDUT5rEU6pqM&index=24', // Remplacez par l'ID réel de votre vidéo YouTube
                    flags: const YoutubePlayerFlags(
                      autoPlay: false,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Fermer',style: TextStyle(
                    color: Colors.orange,
                  ),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.orange, // Couleur de la bordure supérieure
            width: 1.0, // Épaisseur de la bordure supérieure
          ),
        ),
      ),
      child:  SizedBox(
        width:1000 ,
        height: 60,
        child:  Center(
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
                const EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Padding interne
              ),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const  TextStyle(
                  fontSize: 12, // Taille du texte
                  fontWeight: FontWeight.bold, // Épaisseur du texte
                ),
              ),
            ),
            onPressed: () {
              _showModalBottomSheet(context); // Utilisation de l'expression lambda pour onPressed
              // FormHelper.showMessage2( context,'hgdhgd', "Message", "valid",
              // (){
              // },corps());
            },
            child: const Text('Trouver une demonstration ici',style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }
}
