import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snapgrade/views/buat_kunci.dart';
import 'package:snapgrade/views/periksa_jawaban.dart';
import 'package:snapgrade/views/widgets/circlebutton.dart';
import 'package:snapgrade/views/widgets/topbar.dart';

class NewquizPage extends StatefulWidget {
  const NewquizPage({super.key});

  @override
  State<NewquizPage> createState() => _NeqQuizPageState();
}

class _NeqQuizPageState extends State<NewquizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopBar(),
            Container(
              height: 800,
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(40, 28, 40, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nama Kuis',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFEDEEEF),
                      hintText: 'Nama Kuis',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Kelas',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFEDEEEF),
                      hintText: 'Kelas',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Jumlah Pertanyaan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFEDEEEF),
                      hintText: 'Jumlah Pertanyaan',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleButton(
                        title: 'Buat Kunci',
                        icon: Image.asset(
                          'assets/key.png',
                          width: double.infinity,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BuatkunciPage()),
                          );
                        },
                      ),
                      CircleButton(
                        title: 'Periksa Jawaban',
                        icon: Image.asset(
                          'assets/scan.png',
                          width: double.infinity,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PeriksajawabanPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
