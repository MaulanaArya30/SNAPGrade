import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapgrade/views/widgets/circlebutton.dart';
import 'package:snapgrade/views/widgets/topbar.dart';

class PeriksajawabanPage extends StatefulWidget {
  const PeriksajawabanPage({super.key});

  @override
  State<PeriksajawabanPage> createState() => _PeriksajawabanPageState();
}

class _PeriksajawabanPageState extends State<PeriksajawabanPage> {
  File? _image;
  bool imageLoaded = false;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        imageLoaded = true;
      });
    }
  }

  Future<void> matchAnswer(BuildContext context) async {
    //loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
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
    await Future.delayed(Duration(seconds: 3));

    Navigator.pop(context);

    showScore(context, 80);
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
              Text(
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
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 90,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 209,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: Color(0xFF5A5F73),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Center(
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
              TopBar(),
              SizedBox(height: 64),
              Text(
                'Periksa Jawaban',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 40),
              _image == null ? Text('') : Image.file(_image!),
              SizedBox(height: 20),
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
                          color: Color(0xFF424C71),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Center(
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
