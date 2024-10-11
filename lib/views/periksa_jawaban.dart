import 'dart:io';
import 'dart:io' as io; 

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapgrade/views/widgets/circlebutton.dart';
import 'package:snapgrade/views/widgets/topbar.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http_parser/http_parser.dart';
import 'package:snapgrade/views/splash.dart';

class PeriksajawabanPage extends StatefulWidget {
  final Uint8List masterImage;
  PeriksajawabanPage({super.key, required this.masterImage});

  @override
  State<PeriksajawabanPage> createState() => _PeriksajawabanPageState();
}

class _PeriksajawabanPageState extends State<PeriksajawabanPage> {
  Uint8List? studentImage;
  String responseMessage = '';
  Uint8List? decodedImage;
  bool imageLoaded = false;
  File? _image;

  // Future<void> _pickImage() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(type: FileType.image);
  //   if (result != null && result.files.single.bytes != null) {
  //     setState(() {
  //       studentImage = result.files.single.bytes;
  //       _image = File(result.files.single.path!);
  //       imageLoaded = true;
  //     });
  //   }
  // }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    
    if (result != null) {
      setState(() {
        studentImage = result.files.single.bytes;
        
        // On mobile platforms, set the File path
        if (!kIsWeb) {
          _image = io.File(result.files.single.path!);
        }

        imageLoaded = true;
      });
    }
  }


  Future<void> submitImages() async {
    if (studentImage == null) {
      setState(() {
        responseMessage = "Please upload the student image.";
      });
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:5000/process-circles'),
    );

    request.files.add(http.MultipartFile.fromBytes(
      'master_sheet',
      widget.masterImage,
      filename: 'master_sheet.jpg',
      contentType: MediaType('image', 'jpeg'),
    ));

    request.files.add(http.MultipartFile.fromBytes(
      'student_answer',
      studentImage!,
      filename: 'student_answer.jpg',
      contentType: MediaType('image', 'jpeg'),
    ));

    try {
      var streamedResponse = await request.send();
      if (streamedResponse.statusCode == 200) {
        var response = await http.Response.fromStream(streamedResponse);
        var data = json.decode(response.body);

        // Decode the Base64 image from 'student_answer_key'
        String base64Image = data['student_answer_key'];
        Uint8List decodedBytes = base64Decode(base64Image);

        setState(() {
          responseMessage =
              'Score: ${data['score']}, Total Questions: ${data['total_questions']}, Mistakes: ${data['mistakes']}, Time: ${data['time']} seconds';
          decodedImage = decodedBytes;
        });

        showScore(context, data['score']);
      } else {
        setState(() {
          responseMessage = 'Failed to upload images.';
        });
      }
    } catch (e) {
      setState(() {
        responseMessage = 'Error: $e';
      });
    }
  }

  Future<void> matchAnswer(BuildContext context) async {
    //loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Memeriksa Jawaban...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 3));

    await submitImages();

    Navigator.pop(context);
  }

  void showScore(BuildContext context, int score) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Memeriksa Jawaban...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                score.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 90,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 209,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF5A5F73),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          color: Colors.white,
          child: Column(
            children: [
              const TopBar(),
              const SizedBox(height: 64),
              const Text(
                'Periksa Jawaban',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 40),
              _image == null ? const Text('') : Image.file(_image!),
              const SizedBox(height: 20),
              !imageLoaded
                  ? CircleButton(
                      title: 'Unggah Jababan',
                      icon: Image.asset('assets/upload.png'),
                      onPressed: _pickImage,
                    )
                  : InkWell(
                      child: Container(
                        width: 180,
                        height: 48,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF424C71),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'PERIKSA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        matchAnswer(context);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
