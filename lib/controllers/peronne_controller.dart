
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:oneci/modeles/info_personne.dart';
import 'package:oneci/services/services.dart';

class PersonneController extends GetxController{
  var isLoading= true.obs;
  var isTrue = false.obs;


  var infoData = InfoPersonne().obs;

  @override
  void onInit() {
    // TODO: implement onInit
   //== fetchVerification(_nni);
    super.onInit();
  }

  Future<void> fetchVerification({String? nni="22222222222"}) async{
    try{
      isLoading(true);
      var informations = await Services.getInfoUtilisateur(nni!);

      if(informations != null){

        infoData.value = informations;
        //print("VERRR ${postModel.value}");
      }
    }finally{
      isLoading(false);
    }
  }



}