import 'dart:io';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:image/image.dart' as img;
import 'package:ugocash/config/routes.dart';

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
  void requestPermission() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isGranted) {
      print('Camera permission granted');
    } else if (status.isDenied) {
      Permission.sms.request();
      // Permission is denied
      print('Camera permission denied');
    } else if (status.isPermanentlyDenied) {
      // Permission is permanently denied
      print('Camera permission permanently denied');
    }
  }

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  File? _image;
  // List<CameraDescription> cameras = [];

  void _initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    // cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
// _initializeCamera();

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

  File? _idPhoto;

  Future<bool> _matchImages() async {
    final idImage = img.decodeImage(await _idPhoto!.readAsBytes());
    final uploadedImage = img.decodeImage(await _image!.readAsBytes());

    // Perform face contour extraction using image processing techniques
    final idContour = _extractFaceContour(idImage!);
    final uploadedContour = _extractFaceContour(uploadedImage!);

    if (idContour != null && uploadedContour != null) {
      // Compare the face contour of the uploaded image with the face contour of the ID photo to check for a match
      final isMatch = _compareFaceContours(uploadedContour, idContour);
      return isMatch;
    } else {
      print('No face detected in one or both images!');
      return false;
    }
  }

  ui.Rect? _extractFaceContour(img.Image image) {
    // Implement your face contour extraction logic here using image processing techniques
    // Return the face contour rectangle or null if no face is detected

    // For demonstration, returning a hardcoded face rectangle
    return ui.Rect.fromLTWH(100, 100, 200, 200);
  }

  bool _compareFaceContours(ui.Rect uploadedContour, ui.Rect idContour) {
    // Implement your face contour comparison logic here
    // Return true or false based on the comparison result

    final uploadedPoints = _getContourPoints(uploadedContour);
    final idPoints = _getContourPoints(idContour);

    if (uploadedPoints.length != idPoints.length) {
      return false;
    }

    for (int i = 0; i < uploadedPoints.length; i++) {
      final uploadedPoint = uploadedPoints[i];
      final idPoint = idPoints[i];

      if (_calculateEuclideanDistance(uploadedPoint, idPoint) > 5.0) {
        // Adjust the threshold value (5.0) based on your specific requirements
        return false;
      }
    }

    return true;
  }

  List<ui.Offset> _getContourPoints(ui.Rect contour) {
    // Return a list of contour points for the given rectangle
    return [
      contour.topLeft,
      ui.Offset(contour.left + contour.width / 2, contour.top),
      ui.Offset(contour.right, contour.top),
      ui.Offset(contour.right, contour.top + contour.height / 2),
      contour.bottomRight,
      ui.Offset(contour.left + contour.width / 2, contour.bottom),
      ui.Offset(contour.left, contour.bottom),
      ui.Offset(contour.left, contour.top + contour.height / 2),
    ];
  }

  double _calculateEuclideanDistance(ui.Offset point1, ui.Offset point2) {
    final dx = point1.dx - point2.dx;
    final dy = point1.dy - point2.dy;
    return math.sqrt(dx * dx + dy * dy);
  }

// _matchImages() async {
//   final dio = Dio();
//   final response = await dio.get('https://api.dwolla.com/photos/user-id-photo');
//   final idPhotoPath = response.data['url'];

//   final uploadedImage = FirebaseVisionImage.fromFile(_uploadedImage!);
//   final idPhoto = FirebaseVisionImage.fromFile(File(idPhotoPath));

//   final faceDetector = FirebaseVision.instance.faceDetector();
//   final uploadedFaces = await faceDetector.processImage(uploadedImage);
//   final idFaces = await faceDetector.processImage(idPhoto);
// if (uploadedFaces.length == 1 && idFaces.length == 1) {
//     final uploadedContour = uploadedFaces[0].getContour(FaceContourType.allPoints);
//     final idContour = idFaces[0].getContour(FaceContourType.allPoints);
//     return _compareContours(uploadedContour!, idContour!);
//     // Compare the face contour of the uploaded image with the face contour of the ID photo to check for a match.
//   } else {
//     print('No face or multiple faces detected!');
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          // if (_image != null) {
          //   _matchImages();
          // } else {
          _takePicture();
          Fluttertoast.showToast(
              msg: "Image captured",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0);
          Navigator.pushReplacementNamed(context, Routes.kycquestion);
          // }
        },
      ),
    );
  }
}
