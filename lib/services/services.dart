import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:oneci/modeles/info_personne.dart';
import 'package:oneci/utils/config.dart';

class Services {
  static var client = http.Client();

 /* static Future<InfoPersonne> getInfoUtilisateur(int nni) async {
    var url ="${Config.baseUrl}/verification/data/$nni";
    var response = await client.get(Uri.parse(url));

    if(response.statusCode == 200){
      var jsonString = response.body;
      // tableau de id des post
      // ensuite j'envoi ça
      return dataFromJson(jsonString);
    }else{
      return null;
    }

  }*/

  static Future<InfoPersonne> getInfoUtilisateur(String nni) async{
    var url ="${Config.baseUrl}/verification/data/$nni";
    var response = await client.get(Uri.parse(url));
    final jsonresponse = json.decode(response.body);

    print("YYYYYYYYYYYYYYYYY ${jsonresponse}");

    return InfoPersonne.fromJson(jsonresponse);
  }

  static Future<bool> getExistePersonne(String nni) async{
    var url ="${Config.baseUrl}/verification/$nni";
    var response = await client.get(Uri.parse(url));
    final jsonresponse = json.decode(response.body);

    //print("YYYYYYYYYYYYYYYYY ${jsonresponse}");
    if(jsonresponse['data'] == "true"){
      return true;
    }

    return false ;
  }

  static Future<bool> getExisteParentEnfants(String nni,String nni_parent) async{
    var url ="${Config.baseUrl}/verification/fils/$nni/$nni_parent";
    var response = await client.get(Uri.parse(url));
    final jsonresponse = json.decode(response.body);

    //print("YYYYYYYYYYYYYYYYY ${jsonresponse}");
    if(jsonresponse['data'] == "true"){
      return true;
    }

    return false ;
  }

/*  static Future<bool> changeStatutNotification(String id) async{

    var url =Config.apiSymfony.toString() + Config.changeStatutNotification + id.toString();
    var response = await client.post(Uri.parse(url));

    if(response.statusCode == 200){
      var jsonString = response.body ;
      //print(fromJsonToDetail(jsonString));
      print("98888888888888888888888888888888888 ${jsonString}");
      return true;


    }
    return false;
  }*/
}