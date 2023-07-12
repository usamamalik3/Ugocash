import 'dart:io';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:image/image.dart' as img;
import 'package:ugocash/config/routes.dart';
import 'package:ugocash/global.dart';

class KYCScreen extends StatefulWidget {
  const KYCScreen({
    Key? key,
    required this.cameras,
  }) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  _KYCScreenState createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  File? _image;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.cameras[1],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      setState(() {
        _image = File(image.path);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _uploadimage() async {
    var id = GlobalVariables.customerId;
    final url =
        Uri.parse('https://www.ugoya.net/api/$id/document/createForCustomer');
    var request = http.MultipartRequest('POST', url);
    // request.headers['Authorization'] = 'Bearer <your_access_token_here>';
    request.fields['documentType'] = "other";
    request.files.add(await http.MultipartFile.fromPath('file', _image!.path,
        contentType: MediaType('image', 'jpeg')));
    var response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "image uploaded Succesfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "image uploaded error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _image == null
          ? FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(
                    _image!,
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ),
      floatingActionButton: _image == null
          ? FloatingActionButton.extended(
              onPressed: _takePicture,
              label: Icon(Icons.camera_alt),
            )
          : FloatingActionButton.extended(
              label: Icon(Icons.upload),
              onPressed: _uploadimage,
            ),
    );
  }
}
