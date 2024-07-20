import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;
import 'package:oneci/ecrans/home.dart';

void main()  {
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

