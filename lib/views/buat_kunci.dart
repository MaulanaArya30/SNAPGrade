import 'package:flutter/material.dart';
import 'package:snapgrade/views/widgets/circlebutton.dart';
import 'package:snapgrade/views/widgets/topbar.dart';

class BuatkunciPage extends StatelessWidget {
  const BuatkunciPage({super.key});

  Future<dynamic> kunciTerunggah(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Kunci terunggah',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Image.asset(
                'assets/checklist.png',
                width: 100,
              ),
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const TopBar(),
            const SizedBox(height: 64),
            const Text(
              'Buat Kunci',
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 40),
            CircleButton(
              title: 'Unggah Kunci',
              icon: Image.asset('assets/upload.png'),
              onPressed: () {
                kunciTerunggah(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
