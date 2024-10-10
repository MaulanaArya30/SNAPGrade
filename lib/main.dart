import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http_parser/http_parser.dart';

void main() {
  runApp(MaterialApp(home: ImageUploadPage()));
}

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  Uint8List? masterImage; 
  Uint8List? studentImage; 
  String responseMessage = '';
  Uint8List? decodedImage;


  Future<void> pickImage(bool isMaster) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        if (isMaster) {
          masterImage = result.files.single.bytes;
        } else {
          studentImage = result.files.single.bytes;
        }
      });
    }
  }

  Future<void> submitImages() async {
    if (masterImage == null || studentImage == null) {
      setState(() {
        responseMessage = "Please upload both images.";
      });
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:5000/process-circles'),
    );

    request.files.add(http.MultipartFile.fromBytes(
      'master_sheet',
      masterImage!,
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
          decodedImage = decodedBytes;  // Store the decoded image
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SNAPGrade'),
      ),
      body: SingleChildScrollView( 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => pickImage(true),
                child: const Text('Upload Master Sheet'),
              ),
               if (masterImage != null) const Text("Master Sheet Image Selected"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => pickImage(false),
                child: const Text('Upload Student Answer Sheet'),
              ),
              if (studentImage != null) const Text("Student Answer Image Selected"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitImages,
                child: const Text('Submit Images and Get Score'),
              ),
              const SizedBox(height: 20),
              Text(responseMessage),
              if (decodedImage != null)
                Column(
                  children: [
                    const Text('Student Mistake(s):'),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8, 
                      height: MediaQuery.of(context).size.height * 0.5, 
                      child: Image.memory(
                        decodedImage!,
                        fit: BoxFit.contain, // Make the image fit within the box
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ORIGINAL 
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:snapgrade/views/buat_kunci.dart';
// import 'package:snapgrade/views/dashboard.dart';
// import 'package:snapgrade/views/new_quiz.dart';
// import 'package:snapgrade/views/periksa_jawaban.dart';
// import 'package:snapgrade/views/splash.dart';
// import 'package:snapgrade/api_call.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       home: NewquizPage(),
//     );
//   }
// }
