import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

List<InfoPersonne> dataFromJson(String str)=>
    List<InfoPersonne>.from(
      json.decode(str).map(
            (x)=>InfoPersonne.fromJson(x),
      ),
    );


InfoPersonne fromJsonToDetail(String str) => InfoPersonne.fromJson( json.decode(str).map(
      (x)=>InfoPersonne.fromJson(x),
),);


class InfoPersonne {
  int? id;
  String? nom;
  String? prenoms;
  //String? sexe;
  String? numero;
  String? image;


  InfoPersonne( {
    this.id,
    this.nom,
    this.prenoms,
    //this.sexe,
    this.numero,
    this.image
  });

  factory InfoPersonne.fromJson1(Map<String, dynamic> addjson){

    return InfoPersonne(
        id: addjson["id"],
        nom:  addjson["nom"],
      prenoms:  addjson["prenoms"],
     // sexe:  addjson["sex"],
      numero:  addjson["nni"],
      image:  addjson["image"],

      // }
    );
  }

  InfoPersonne.fromJson(Map<String,dynamic> json){
    id= json['id'];
    nom= json['nom'];
    prenoms= json['prenoms'];
    numero= json['nni'];
    image= json['image'];


  }
}